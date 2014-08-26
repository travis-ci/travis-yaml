module Travis::Yaml
  module Serializer
    class Yaml < Ruby
      PSYCH_OPTIONS = [ :indentation, :line_width, :canonical ]

      class Tagged
        attr_accessor :tag, :value
        def initialize(tag, value)
          @tag, @value = tag, value
        end

        def encode_with(coder)
          coder.represent_scalar(tag, value)
        end
      end

      def self.serialize(node, options = nil)
        psych_options = options.select { |key, _| PSYCH_OPTIONS.include? key } if options
        ::Psych.dump(super, psych_options || {})
      end

      def avoid_tags?
        !!options[:avoid_tags]
      end

      def serialize_encrypted(value)
        value = value.encrypted_string
        avoid_tags? ? { "secure" => value } : Tagged.new('!encrypted', value)
      end

      def serialize_decrypted(value)
        value = value.decrypted_string
        avoid_tags? ? value : Tagged.new('!decrypted', value)
      end

      def serialize_binary(value)
        Tagged.new('!binary', [value].pack('m0'))
      end
    end
  end
end