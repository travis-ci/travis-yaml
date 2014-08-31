module Travis::Yaml
  module Nodes
    class Scalar < Node
      def self.[](*types)
        Class.new(self) do
          default_type(types.first)
          cast(*types)
        end
      end

      def self.cast?(type)
        cast.include? type
      end

      def self.cast(*types)
        @cast ||= superclass.respond_to?(:cast) ? superclass.cast.dup : []
        @cast.concat(types) if types.any?
        @cast
      end

      def self.default_type(type = nil)
        @default_type = type if type
        @default_type ||= superclass.respond_to?(:default_type) ? superclass.default_type : :str
      end

      def self.default(value = nil)
        @default = value if value
        @default ||= nil
      end

      def self.has_default?
        !default.nil?
      end

      attr_accessor :value
      alias_method :__getobj__, :value

      def empty?
        value.nil?
      end

      def prepare
        self.value = self.class.default
        @multiple  = false
        super
      end

      def ==(other)
        other = other.value if other.is_a? self.class
        other == value
      end

      def default_type
        self.class.default_type
      end

      def inspect
        value.inspect
      end

      def visit_scalar(visitor, type, value, implicit = true)
        return self.value = cast(visitor, type,         value) if cast? type
        return self.value = cast(visitor, default_type, value) if implicit
        error "%p not supported, dropping %p", type.to_s, cast(visitor, :str, value)
      end

      def visit_sequence(visitor, value)
        @multiple = false
        visitor.apply_sequence(self, value)
      end

      def visit_child(visitor, value)
        if @multiple
          value = cast(visitor, :str, value) rescue value
          warning "does not support multiple values, dropping %p", value
        else
          @multiple = true
          visitor.accept(self, value)
        end
      end

      def cast(visitor, type, value)
        visitor.cast(type, value)
      rescue ArgumentError => error
        error "failed to parse %p - %s", type.to_s, error.message.sub("():", ":")
      end

      def cast?(type)
        self.class.cast?(type) or type == default_type
      end

      def !@
        !value
      end

      def with_value(value)
        return value.dup if value.is_a? self.class
        value = value.value while value.is_a? Scalar
        super(value)
      end

      def with_value!(value)
        self.value = value
      end

      def each_scalar(type = nil, &block)
        return enum_for(:each_scalar, type) unless block
        yield value if type.nil? or type === value
      end
    end
  end
end