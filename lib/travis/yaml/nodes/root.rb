module Travis::Yaml
  module Nodes
    class Root < Mapping
      include LanguageSpecific

      map :language, required: true
      map :bundler_args, to: BundlerArgs
      map :deploy, :ruby, :os, :compiler, :git, :jdk, :virtualenv, :matrix, :env, :notifications, :branches, :cache, :addons
      map :lein, :otp_release, :go, :ghc, :xcode_sdk, :xcode_scheme, :perl, :php, :python, :services, :gemfile, to: VersionList
      map :node_js, to: VersionList[/^\d+\.\d+(\.\d+)?$/]
      map :rvm, to: :ruby
      map :otp, to: :otp_release
      map :node, to: :node_js
      map :virtual_env, to: :virtualenv
      map :osx_image, to: Version, experimental: true
      map :gobuild_args, :xcode_project, :xcode_workspace, :xctool_args, :composer_args, :npm_args, to: Scalar[:str]
      map :source_key, to: Scalar[:str, :secure]
      map :sdk_components, to: Sequence
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
        warning 'your repository must be feature flagged for the "os" setting to be used' if os and os != language.default_os

        if os.include? 'osx' and jdk
          # https://github.com/travis-ci/travis-ci/issues/2317
          warning 'dropping "jdk" section: currently not supported on "osx"'
          @mapping.delete('jdk')
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