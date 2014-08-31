module Travis::Yaml
  module Serializer
    class Generic
      attr_reader :options

      def self.serialize(node, options = nil)
        new(options).serialize(node)
      end

      def initialize(options = nil)
        @options = options || {}
      end

      def symbol_keys?
        !!options[:symbol_keys]
      end

      def serialize(node)
        case node 
        when Nodes::Root     then serialize_root(node)
        when Nodes::Scalar   then serialize_scalar(node)
        when Nodes::Mapping  then serialize_mapping(node)
        when Nodes::Sequence then serialize_sequence(node)
        else raise NotSupportedError, 'do not know how to serialize %p' % node.class
        end
      end

      def serialize_scalar(node)        
        case value = node.value
        when true, false  then serialize_bool(value)
        when Float        then serialize_float(value)
        when Integer      then serialize_integer(value)
        when Time         then serialize_time(value)
        when SecureString then serialize_secure(value)
        when Regexp       then serialize_regexp(value)
        when String
          value.encoding == Encoding::BINARY ? serialize_binary(value) : serialize_str(value)
        else
          serialize_value(node)
        end
      end

      def serialize_bool(value)
        serialize_value(value)
      end

      def serialize_float(value)
        serialize_value(value)
      end

      def serialize_time(value)
        serialize_value(value)
      end

      def serialize_secure(value)
        case options[:secure]
        when :decrypted
          raise ArgumentError, 'secure option is set decrypted, but a secure value is not decrypted' unless value.decrypted?
          serialize_decrypted(value)
        when :encrypted
          raise ArgumentError, 'secure option is set encrypted, but a secure value is not encrypted' unless value.encrypted?
          serialize_encrypted(value)
        else
          raise ArgumentError, 'unexpected value for secure option: %p' % options[:secure] if options[:secure]
          value.encrypted? ? serialize_encrypted(value) : serialize_decrypted(value)
        end
      end

      def serialize_encrypted(value)
        serialize_value(value)
      end

      def serialize_decrypted(value)
        serialize_value(value)
      end

      def serialize_regexp(value)
        serialize_value(value)
      end

      def serialize_str(value)
        serialize_value(value)
      end

      def serialize_binary(value)
        serialize_str(value)
      end

      def serialize_bool(value)
        serialize_value(value)
      end

      def serialize_value(value)
        raise NotSupportedError, 'cannot serialize %p with %p' % [node.class, self.class]
      end

      def serialize_root(node)
        serialize_mapping(node)
      end

      def serialize_mapping(node)
        node.map { |key, value| [serialize_key(key), serialize(value)] }
      end

      def serialize_sequence(node)
        node.map { |value| serialize(value) }
      end

      def serialize_key(value)
        symbol_keys? ? value.to_sym : value.to_s
      end
    end
  end
end