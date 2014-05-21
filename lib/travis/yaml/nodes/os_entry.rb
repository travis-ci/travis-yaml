module Travis::Yaml
  module Nodes
    class OSEntry < FixedValue
      MISSING = {
        # see https://github.com/travis-ci/travis-ci/issues/2320
        'osx'   => %w[node_js python php perl erlang groovy clojure scala go haskell],
        'linux' => ['objective-c']
      }

      ignore_case
      default :linux
      value :linux, ubuntu: :linux
      value :osx, mac: :osx, macos: :osx

      def supports_language?(language)
        return false unless missing = MISSING[value]
        !missing.include?(language)
      end
    end
  end
end