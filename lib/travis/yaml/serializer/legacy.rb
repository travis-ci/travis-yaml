module Travis::Yaml
  module Serializer
    class Legacy < Ruby
      def serialize_root(node)
        return serialize_error(node) if node.errors?
        super.merge(serialize_warnings(node))
      end

      def serialize_error(node)
        {
          serialize_key('.result')         => 'parse_error',
          serialize_key('.result_message') => node.errors.join("\n")
        }
      end

      def serialize_warnings(node)
        {
          serialize_key('.result')          => 'configured',
          serialize_key('.result_warnings') => node.nested_warnings
        }
      end

      def serialize_encrypted(value)
        { serialize_key('secure') => value.encrypted_string }
      end

      def serialize_decrypted(value)
        value.decrypted_string
      end
    end
  end
end