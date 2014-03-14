module Travis::Yaml
  class SecureString
    attr_accessor :encrypted_string, :decrypted_string
    def initialize(string, encrypted = true)
      if encrypted
        @encryped_string = string
      else
        @decrypted_string = string
      end
    end
  end
end
