module Travis::Yaml
  module Nodes
    class OS < Sequence
      type OSEntry

      def verify_language(language)
        children.delete_if do |os|
          next false if os.supports_language? language
          warning "dropping %s, does not support %s", os, language
          true
        end

        if children.empty?
          default_os = language.respond_to?(:default_os) ? language.default_os : OSEntry.default
          warning "no suitable operating system given for %s, using %s", language, default_os
          children << OSEntry.new(self) { |os| os.value = default_os }
        end
      end
    end
  end
end