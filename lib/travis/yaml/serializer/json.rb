module Travis::Yaml
  module Serializer
    class Json < Generic
      MAP = { # mapping stolen from json gem
        "\x0"  => '\u0000', "\x1"  => '\u0001', "\x2"  => '\u0002', "\x3"  => '\u0003', "\x4"  => '\u0004', "\x5"  => '\u0005',
        "\x6"  => '\u0006', "\x7"  => '\u0007', "\b"   =>  '\b',    "\t"   =>  '\t',    "\n"   => '\n',     "\xb"  => '\u000b',
        "\f"   => '\f',     "\r"   =>  '\r',    "\xe"  => '\u000e', "\xf"  => '\u000f', "\x10" => '\u0010', "\x11" => '\u0011',
        "\x12" => '\u0012', "\x13" => '\u0013', "\x14" => '\u0014', "\x15" => '\u0015', "\x16" => '\u0016', "\x17" => '\u0017',
        "\x18" => '\u0018', "\x19" => '\u0019', "\x1a" => '\u001a', "\x1b" => '\u001b', "\x1c" => '\u001c', "\x1d" => '\u001d',
        "\x1e" => '\u001e', "\x1f" => '\u001f', '"'    =>  '\"',    '\\'   =>  '\\\\'
      }

      def pretty?
        !!options[:pretty]
      end

      def serialize_float(value)
        raise NotSupportedError, 'cannot serialize infinity as JSON' if value.infinite?
        "#{value}"
      end

      def serialize_encrypted(value)
        key_value("secure", serialize_str(value.encrypted_string), "{%s}")
      end

      def serialize_decrypted(value)
        serialize_str(value.decrypted_string)
      end

      def serialize_str(value)
        string = value.encode('utf-8')
        string.force_encoding('binary')
        string.gsub!(/["\\\x0-\x1f]/) { MAP[$&] }
        string.force_encoding('utf-8')
        "\"#{string}\""
      end

      def serialize_binary(value)
        raise NotSupportedError, 'cannot serialize binary data as JSON'
      end

      def serialize_bool(value)
        value ? "true" : "false"
      end

      def serialize_mapping(node)
        lines('{%s}', super.map { |key, value| key_value(key, value) })
      end

      def serialize_sequence(node)
        lines('[%s]', super)
      end

      def key_value(key, value, wrapper = "%s")
        space = pretty? ? " " : ""
        wrapper % "#{serialize_str(key)}:#{space}#{value}"
      end

      def lines(wrapper, lines)
        return wrapper % lines.join(',') unless pretty?
        return wrapper % "" if lines.empty?
        return wrapper % " #{lines.first} " unless lines.size > 1 or  lines.first.include?("\n") or lines.first.size > 50
        lines = "\n  " + lines.join(",\n").strip.gsub("\n", "\n  ") + "\n"
        wrapper % lines
      end

      def serialize_key(value)
        value.to_s
      end
    end
  end
end