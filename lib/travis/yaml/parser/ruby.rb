require 'time'

module Travis::Yaml
  module Parser
    class Ruby
      def self.parses?(value)
        value.is_a? Hash
      end

      def self.parse(value)
        new(value).parse
      end

      def initialize(value, implicit = false)
        @value    = value
        @implicit = implicit
      end

      def parse(root = nil)
        root ||= Travis::Yaml::Nodes::Root.new
        accept(root, @value)
        root
      end

      def accept(node, value)
        case value
        when Array                then node.visit_sequence   self, value
        when Hash                 then node.visit_mapping    self, value
        when SecureString         then node.visit_scalar     self, :secure, value,      @implicit
        when String               then node.visit_scalar     self, :str,    value,      @implicit
        when Symbol               then node.visit_scalar     self, :str,    value.to_s, @implicit
        when Integer              then node.visit_scalar     self, :int,    value,      @implicit
        when Float                then node.visit_scalar     self, :float,  value,      @implicit
        when DateTime, Time, Date then node.visit_scalar     self, :time,   value,      @implicit
        when true, false          then node.visit_scalar     self, :bool,   value,      @implicit
        when Regexp               then node.visit_scalar     self, :regexp, value,      @implicit
        when nil                  then node.visit_scalar     self, :null,   value,      @implicit
        else                           node.visit_unexpected self, value
        end
        node.verify
      end

      def cast(type, value)
        case type
        when :str    then value.to_s
        when :binary then value.unpack('m').first
        when :bool   then !!value
        when :float  then Float   value
        when :int    then Integer value
        when :time   then value.to_time
        when :secure then SecureString === value ? value : SecureString.new(value.value)
        when :regexp then Regexp.new(value)
        when :null   then nil
        else raise ArgumentError, 'unknown scalar type %p' % type
        end
      rescue RegexpError => error
        raise ArgumentError, "broken regular expression - #{error.message}"
      end

      def apply_mapping(node, value)
        value.each_pair { |key, value| node.visit_pair(self, key, value) }
      end

      def apply_sequence(node, value)
        value.each { |child| node.visit_child(self, child) }
      end

      def generate_key(node, value)
        case value
        when String then value
        when Symbol then value.to_s
        else node.visit_unexpected(self, value, "expected string as key")
        end
      end
    end
  end
end
