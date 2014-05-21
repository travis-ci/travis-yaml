module Travis::Yaml
  module Nodes
    class Version < Scalar
      def self.[](expression)
        Class.new(self) { format(expression) }
      end

      def self.format(expression = nil)
        @format = expression if expression
        @format ||= superclass.respond_to?(:format) ? superclass.format : //
      end

      def value=(value)
        return super unless value and value.to_s !~ self.class.format
        error "value %p is not a valid version", value.to_s
      end
    end
  end
end