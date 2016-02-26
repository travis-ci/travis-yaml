module Travis::Yaml
  module Nodes
    module LanguageSpecific
      LANGUAGE_SPECIFIC = {
        bundler_args:     %w[ruby],
        compiler:         %w[c cpp],
        lein:             %w[clojure],
        dart:             %w[dart],
        otp_release:      %w[erlang],
        gobuild_args:     %w[go],
        go:               %w[go],
        jdk:              %w[clojure groovy java ruby scala android],
        ghc:              %w[haskell],
        haxe:             %w[haxe],
        neko:             %w[haxe],
        hxml:             %w[haxe],
        node_js:          %w[node_js],
        ruby:             %w[ruby objective-c],
        xcode_sdk:        %w[objective-c],
        xcode_scheme:     %w[objective-c],
        xcode_project:    %w[objective-c],
        xcode_workspace:  %w[objective-c],
        xctool_args:      %w[objective-c],
        perl:             %w[perl],
        php:              %w[php],
        python:           %w[python],
        virtualenv:       %w[python],
        gemfile:          %w[ruby objective-c],
        composer_args:    %w[php],
        npm_args:         %w[node_js],
        android:          %w[android],
        d:                %w[d],
        crystal:          %w[crystal],
        solution:         %w[csharp],
        smalltalk:        %w[smalltalk]
      }

      def verify_language(language)
        LANGUAGE_SPECIFIC.each do |key, languages|
          next unless include? key and not languages.include? language.value
          mapping.delete mapped_key(key)
          warning "specified %p, but setting is not relevant for %p", key.to_s, language
        end

        mapping.each_value do |value|
          value.verify_language(language) if value.respond_to? :verify_language
        end

        verify_errors
      end
    end
  end
end
