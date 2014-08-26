module Travis::Yaml
  module Serializer
    class Legacy < Ruby
      def serialize_root(node)
        return '.result' => 'parse_error', '.result_message' => node.errors.join("\n") if node.errors?
        super.merge('.result' => 'configured', '.result_warnings' => node.nested_warnings)
      end

      def serialize_encrypted(value)
        { 'secure' => value.encrypted_string }
      end

      def serialize_decrypted(value)
        value.decrypted_string
      end
    end
  end
end