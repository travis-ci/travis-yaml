module Travis::Yaml
  module Nodes
    class Root < Mapping
      include LanguageSpecific

      map :language, required: true
      map :sudo, to: Scalar[:bool], required: false
      map :bundler_args, to: BundlerArgs
      map :deploy, :ruby, :os, :compiler, :git, :jdk, :virtualenv, :matrix, :env, :notifications, :branches, :cache, :addons, :android
      map :lein, :otp_release, :go, :ghc, :haxe, :xcode_sdk, :xcode_scheme, :perl, :php, :python, :services, :gemfile,
        :dart, :scala, :d, :crystal, :smalltalk, to: VersionList
      map :podfile, to: Version
      map :node_js, to: VersionList[/^((iojs)|(iojs\-v\d+\.\d+(\.\d+)?)|(\d+(\.\d+(\.\d+)?)?)|stable|node)$/]
      map :rvm, to: :ruby
      map :otp, to: :otp_release
      map :node, to: :node_js
      map :virtual_env, to: :virtualenv
      map :osx_image, to: Version, experimental: true
      map :gobuild_args, :xcode_project, :xcode_workspace, :xctool_args, :composer_args, :npm_args, to: Scalar[:str]
      map :source_key, to: Scalar[:str, :secure]
      map :before_install, :install, :before_script, :script, :after_result, :before_cache,
            :after_script, :after_success, :after_failure, :before_deploy, :after_deploy, to: Stage
      map :dist, to: Dist
      map :group, to: Group

      FEATURE_KEYS = [:group]

      def initialize
        super(nil)
      end

      def verify
        super
        verify_os
        verify_language(language)
        FEATURE_KEYS.each {|feature| warn_on_feature feature}
      end

      def verify_os
        self.os = language.default_os unless include? :os

        if os.include? 'osx' and jdk
          # https://github.com/travis-ci/travis-ci/issues/2317
          warning 'dropping "jdk" section: currently not supported on "osx"'
          @mapping.delete('jdk')
        end
      end

      def warn_on_feature(feature)
        if include? feature
          warning 'your repository must be feature flagged for the "%s" setting to be used', feature
        end
      end

      def nested_warnings(*)
        super.uniq
      end

      def inspect
        "#<Travis::Yaml:#{super}>"
      end

      def to_matrix
        Travis::Yaml.matrix(self)
      end
    end
  end
end
