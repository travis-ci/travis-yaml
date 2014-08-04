module Travis::Yaml
  module Nodes
    class OS < Sequence
      type OSEntry

      def verify_language(language)
        children.delete_if do |os|
          next false if os.supports_language? language.to_s
          warning "dropping %p, does not support %p", os, language
          true
        end

        if children.empty?
          default_os = language.respond_to?(:default_os) ? language.default_os : OSEntry.default
          warning "no suitable operating system given for %p, using %p", language, default_os.to_s
          children << OSEntry.new(self) { |os| os.value = default_os }
        end
      end
    end
  end
end