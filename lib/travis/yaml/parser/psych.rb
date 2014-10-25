require 'psych'
require 'delegate'

module Travis::Yaml
  module Parser
    class Psych
      class SetNode < DelegateClass(::Psych::Nodes::Mapping)
        def children
          super.select.with_index { |_,i| i.even? }
        end
      end

      class ScalarSequence < DelegateClass(::Psych::Nodes::Mapping)
        def children
          [__getobj__]
        end
      end

      MAP       = /\A(?:tag:yaml\.org,2002:|!!?)map\z/
      OMAP      = /\A(?:tag:yaml\.org,2002:|!!?)omap\z/
      PAIRS     = /\A(?:tag:yaml\.org,2002:|!!?)pairs\z/
      SET       = /\A(?:tag:yaml\.org,2002:|!!?)set\z/
      SEQ       = /\A(?:tag:yaml\.org,2002:|!!?)seq\z/
      BINARY    = /\A(?:tag:yaml\.org,2002:|!!?)binary\z/
      BOOL      = /\A(?:tag:yaml\.org,2002:|!!?)bool\z/
      FLOAT     = /\A(?:tag:yaml\.org,2002:|!!?)float\z/
      INT       = /\A(?:tag:yaml\.org,2002:|!!?)int\z/
      MERGE     = /\A(?:tag:yaml\.org,2002:|!!?)merge\z/
      NULL      = /\A(?:tag:yaml\.org,2002:|!!?)null\z/
      STR       = /\A(?:tag:yaml\.org,2002:|!!?)str\z/
      TIMESTAMP = /\A(?:tag:yaml\.org,2002:|!!?)timestamp\z/
      VALUE     = /\A(?:tag:yaml\.org,2002:|!!?)value\z/
      YAML      = /\A(?:tag:yaml\.org,2002:|!!?)yaml\z/
      SECURE    = /\A!(?:encrypted|secure|decrypted)\z/
      TRUE      = /\A(?:y|Y|yes|Yes|YES|true|True|TRUE|on|On|ON)\z/
      FALSE     = /\A(?:n|N|no|No|NO|false|False|FALSE|off|Off|OFF)\z/
      REGEXP    = /\A!(?:ruby\/)?regexp\z/
      REG_FLAGS = { 'i' => Regexp::IGNORECASE, 'm' => Regexp::MULTILINE, 'x' => Regexp::EXTENDED }
      FORMATS   = {
        '!bool'      => Regexp.union(TRUE, FALSE),
        '!float'     => ::Psych::ScalarScanner::FLOAT,
        '!null'      => /\A(:?~|null|Null|NULL|)\z/,
        '!timestamp' => ::Psych::ScalarScanner::TIME,
        '!int'       => ::Psych::ScalarScanner::INTEGER,
        '!regexp'    => /\A\/(.*)\/([imx]*)\z/
      }

      if defined? ::Psych::ClassLoader
        CLASS_LOADER = ::Psych::ClassLoader.new
        class ScalarScanner < ::Psych::ScalarScanner
          def initialize
            super(CLASS_LOADER)
          end
        end
      else
        ScalarScanner = ::Psych::ScalarScanner
      end

      def self.parses?(value)
        return true if value.is_a?(::Psych::Nodes::Node)
        return true if value.is_a?(String) or value.is_a?(IO)
        return true if defined?(StringIO) and value.is_a?(StringIO)
        value.respond_to?(:to_str) or value.respond_to?(:to_io)
      end

      def self.parse(value)
        new(value).parse
      end

      def initialize(value)
        value    = value.to_str if value.respond_to? :to_str
        value    = value.to_io  if value.respond_to? :to_io
        @value   = value
        @scanner = ScalarScanner.new
      end

      def parse(root = nil)
        root   ||= Travis::Yaml::Nodes::Root.new
        parsed   = @value if @value.is_a? ::Psych::Nodes::Node
        parsed ||= ::Psych.parse(@value)
        accept(root, parsed)
        root
      rescue ::Psych::SyntaxError => error
        root.verify
        root.warnings.clear
        root.error("syntax error: %s", error.message)
        root
      end

      def accept(node, value)
        case value
        when ::Psych::Nodes::Scalar   then accept_scalar   node, value
        when ::Psych::Nodes::Mapping  then accept_mapping  node, value
        when ::Psych::Nodes::Sequence then accept_sequence node, value
        when ::Psych::Nodes::Alias    then accept_alias    node, value
        when ::Psych::Nodes::Document then accept          node, value.root
        when ::Psych::Nodes::Stream   then accept_sequence node, value
        else node.visit_unexpected(self, value) if value
        end
        node.verify
      end

      def accept_sequence(node, value)
        case value.tag
        when SET, SEQ
          node.visit_sequence self, value
        when nil
          value = ScalarSequence.new(value) unless value.is_a? ::Psych::Nodes::Sequence
          node.visit_sequence self, value
        else
          node.visit_sequence self, ScalarSequence.new(value)
        end
      end

      def accept_mapping(node, value)
        case value.tag
        when MAP, OMAP, PAIRS then node.visit_mapping  self, value
        when SET              then node.visit_sequence self, SetNode.new(value)
        when SEQ              then node.visit_sequence self, value
        when nil
          if value.children.size == 2 and value.children.first.value == 'secure'
            secret_value = value.children.last
            if secret_value.is_a? ::Psych::Nodes::Scalar
              secret_value.tag ||= '!secure'
              node.visit_scalar(self, :secure, secret_value, false)
            else
              node.visit_unexpected(self, value, "secret value needs to be a string")
            end
          else
            node.visit_mapping(self, value)
          end
        else
          node.visit_unexpected self, value, "unexpected tag %p for mapping" % value.tag
        end
      end

      def accept_scalar(node, value)
        case tag = scalar_tag(value)
        when BINARY    then node.visit_scalar self, :binary, value, value.tag.nil?
        when BOOL      then node.visit_scalar self, :bool,   value, value.tag.nil?
        when FLOAT     then node.visit_scalar self, :float,  value, value.tag.nil?
        when INT       then node.visit_scalar self, :int,    value, value.tag.nil?
        when NULL      then node.visit_scalar self, :null,   value, value.tag.nil?
        when STR       then node.visit_scalar self, :str,    value, value.tag.nil?
        when TIMESTAMP then node.visit_scalar self, :time,   value, value.tag.nil?
        when SECURE    then node.visit_scalar self, :secure, value, value.tag.nil?
        when NULL      then node.visit_scalar self, :null,   value, value.tag.nil?
        when REGEXP    then node.visit_scalar self, :regexp, value, value.tag.nil?
        else node.visit_unexpected self, value, "unexpected tag %p for scalar %p" % [tag, simple(value)]
        end
      end

      def simple(value)
        case value
        when ::Psych::Nodes::Scalar   then value.value
        when ::Psych::Nodes::Mapping  then simple_mapping(value)
        when ::Psych::Nodes::Sequence then value.children.map { |c| simple(c) }
        when ::Psych::Nodes::Document then simple(value.root)
        when ::Psych::Nodes::Stream   then value.children.map { |c| simple(c) }
        else value
        end
      end

      def simple_mapping(value)
        children     = {}
        keys, values = value.children.group_by.with_index { |_,i| i.even? }.values_at(true, false)
        keys.zip(values) { |key, value| children[simple(key)] = simple(value) } if keys and values
        children
      end

      def scalar_tag(value)
        return value.tag if value.tag
        return '!str' if value.quoted
        FORMATS.each do |tag, format|
          return tag if value.value =~ format
        end
        '!str'
      end

      def regexp(pattern)
        return pattern if pattern.is_a? Regexp
        return Regexp.new(pattern) unless pattern =~ FORMATS['!regexp']
        flag = $2.chars.inject(0) { |f,c| f | REG_FLAGS.fetch(c, 0) }
        Regexp.new($1, flag)
      rescue RegexpError => error
        raise ArgumentError, "broken regular expression - #{error.message}"
      end

      def cast(type, value)
        case type
        when :str    then value.value
        when :binary then value.value.unpack('m').first
        when :bool   then value.value !~ FALSE
        when :float  then Float   @scanner.tokenize(value.value)
        when :int    then Integer @scanner.tokenize(value.value)
        when :time   then @scanner.parse_time(value.value)
        when :secure then SecureString.new(value.value, value.tag != '!decrypted')
        when :regexp then regexp(value.value)
        when :null   then nil
        else raise ArgumentError, 'unknown scalar type %p' % type
        end
      end

      def apply_mapping(node, value)
        keys, values = value.children.group_by.with_index { |_,i| i.even? }.values_at(true, false)
        keys.zip(values) { |key, value| node.visit_pair(self, key, value) } if keys and values
      end

      def apply_sequence(node, value)
        value.children.each { |child| node.visit_child(self, child) }
      end

      def generate_key(node, value)
        if value.respond_to? :value and (value.tag.nil? || value.tag == STR)
          value = value.value.to_s
          value.start_with?(?:) ? value[1..-1] : value
        else
          node.visit_unexpected(self, value, "expected string as key")
        end
      end
    end
  end
end
