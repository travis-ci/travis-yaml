module Travis::Yaml
  class SecureString
    attr_accessor :encrypted_string, :decrypted_string
    def initialize(string, encrypted = true)
      unless string.respond_to? :to_str
        raise ArgumentError, "secure string needs to be a string, not a %p" % string.class.name.downcase
      end
      if encrypted
        @encryped_string = string.to_str
      else
        @decrypted_string = string.to_str
      end
    end
  end
end
