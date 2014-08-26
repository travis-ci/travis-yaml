module Travis::Yaml
  module Serializer
    class Ruby < Generic
      def serialize_value(value)
        value
      end

      def serialize_mapping(node)
        Hash[super]
      end
    end
  end
end