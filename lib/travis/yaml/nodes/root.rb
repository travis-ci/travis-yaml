module Travis::Yaml
  module Nodes
    class Root < Mapping
      LANGUAGE_SPECIFIC = {
        bundler_args: %w[ruby]
      }

      map :language, required: true
      map :bundler_args, to: BundlerArgs
      map :deploy, :ruby, :os
      map :rvm, to: :ruby
      map :before_install, :install, :before_script, :script, :after_result, :after_script,
            :after_success, :after_failure, :before_deploy, :after_deploy, to: Stage

      def initialize
        super(nil)
      end

      def verify
        super
        verify_os
        verify_language_specific
      end

      def verify_os
        self.os = language.default_os unless include? :os
        os.verify_language(language)
      end

      def verify_language_specific
        LANGUAGE_SPECIFIC.each do |key, languages|
          next unless include? key and not languages.include? language
          mapping.delete mapped_key(key)
          warning "specified %p, but setting is not relevant for %p", key.to_s, language
        end
      end

      def nested_warnings(*)
        super.uniq
      end

      def inspect
        "#<Travis::Yaml:#{super}>"
      end
    end
  end
end