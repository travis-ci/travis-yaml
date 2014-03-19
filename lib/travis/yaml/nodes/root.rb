module Travis::Yaml
  module Nodes
    class Root < Mapping
      LANGUAGE_SPECIFIC = {
        bundler_args: %w[ruby],
        compiler:     %w[c cpp],
        lein:         %w[clojure],
        otp_release:  %w[erlang],
        gobuild_args: %w[go],
        go:           %w[go],
        jdk:          %w[clojure groovy java ruby scala]
      }

      map :language, required: true
      map :bundler_args, to: BundlerArgs
      map :deploy, :ruby, :os, :compiler, :git, :jdk
      map :lein, :otp_release, :go, to: VersionList
      map :rvm, to: :ruby
      map :otp, to: :otp_release
      map :gobuild_args, to: Scalar[:str]
      map :before_install, :install, :before_script, :script, :after_result, :after_script,
            :after_success, :after_failure, :before_deploy, :after_deploy, to: Stage

      def initialize
        super(nil)
      end

      def verify
        super
        verify_os
        verify_language_specific
        verify_errors
      end

      def verify_os
        self.os = language.default_os unless include? :os
      end

      def verify_language_specific
        LANGUAGE_SPECIFIC.each do |key, languages|
          next unless include? key and not languages.include? language
          mapping.delete mapped_key(key)
          warning "specified %p, but setting is not relevant for %p", key.to_s, language
        end

        mapping.each_value do |value|
          value.verify_language(language) if value.respond_to? :verify_language
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