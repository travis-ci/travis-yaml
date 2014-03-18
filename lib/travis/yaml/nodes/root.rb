module Travis::Yaml
  module Nodes
    class Root < Mapping
      map :language, required: true
      map :deploy, :ruby, :os
      map :rvm, to: :ruby
      map :before_install, :install, :before_script, :script, :after_result, :after_script,
            :after_success, :after_failure, :before_deploy, :after_deploy, to: Stage

      def verify
        super
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