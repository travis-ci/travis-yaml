module Travis::Yaml
  module Nodes
    class JDK < VersionList
      def verify_language(language)
        return unless language == 'ruby'
        return if @parent.ruby and @parent.ruby.jruby?
        error 'specified "jdk", but "ruby" does not include "jruby"'
      end
    end
  end
end