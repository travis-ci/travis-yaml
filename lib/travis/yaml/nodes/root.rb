module Travis::Yaml
  module Nodes
    class Root < Mapping
      include LanguageSpecific

      map :language, required: true
      map :bundler_args, to: BundlerArgs
      map :deploy, :ruby, :os, :compiler, :git, :jdk, :virtualenv, :matrix, :env, :notifications
      map :lein, :otp_release, :go, :ghc, :node_js, :xcode_sdk, :xcode_scheme, :perl, :php, :python, :services, :gemfile, to: VersionList
      map :rvm, to: :ruby
      map :otp, to: :otp_release
      map :node, to: :node_js
      map :virtual_env, to: :virtualenv
      map :osx_image, to: Version, experimental: true
      map :gobuild_args, :xcode_project, :xcode_workspace, :xctool_args, :composer_args, :npm_args, to: Scalar[:str]
      map :source_key, to: Scalar[:str, :secure]
      map :before_install, :install, :before_script, :script, :after_result, :after_script,
            :after_success, :after_failure, :before_deploy, :after_deploy, to: Stage

      def initialize
        super(nil)
      end

      def verify
        super
        verify_os
        verify_language(language)
      end

      def verify_os
        self.os = language.default_os unless include? :os
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