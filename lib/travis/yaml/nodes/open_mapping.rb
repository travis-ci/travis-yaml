module Travis::Yaml
  module Nodes
    class OpenMapping < Mapping
      def self.default_type(identifier = nil)
        @default_type = Nodes[identifier] if identifier
        @default_type ||= superclass.respond_to?(:default_type) ? superclass.default_type : Scalar
      end

      def self.subnode_for(key)
        super(key) || default_type
      end

      def accept_key?(key)
        key != 'secure'
      end
    end
  end
end