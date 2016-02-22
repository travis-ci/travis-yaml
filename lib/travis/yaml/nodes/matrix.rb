module Travis::Yaml
  module Nodes
    class Matrix < Mapping
      class Matcher < Mapping
        include LanguageSpecific

        map :ruby, :jdk, :lein, :otp_release, :go, :ghc, :haxe, :node_js, :xcode_sdk,
          :xcode_scheme, :perl, :php, :python, :gemfile, :dart, :d, :crystal, :smalltalk, to: Version
        map :rvm, to: :ruby
        map :otp, to: :otp_release
        map :node, to: :node_js
        map :env, to: Env::Variables
        map :os, to: OSEntry
        map :compiler, to: CompilerEntry
      end

      class MatcherList < Sequence
        type Matcher

        def verify_language(language)
          children.each { |c| c.verify_language(language) }
          verify_children
        end
      end

      map :include, :exclude, :allow_failures, to: MatcherList
      map :fast_finish, to: Scalar[:bool]

      def verify_language(language)
        values.each { |v| v.verify_language(language) }
        verify_empty
        verify_errors
      end
    end
  end
end
