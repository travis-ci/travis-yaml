module Travis::Yaml
  module Nodes
    class Scalar < Node
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
        return self.value = visitor.cast(type,         value) if cast? type
        return self.value = visitor.cast(default_type, value) if implicit
        error "%s not supported, dropping %p", type, visitor.cast(:str, value)
      end

      def cast?(type)
        self.class.cast?(type) or type == default_type
      end
    end
  end
end