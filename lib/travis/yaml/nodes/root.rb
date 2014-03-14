module Travis::Yaml
  module Nodes
    class Root < Mapping
      map :language, required: true
      map :deploy, :ruby
      map :rvm, to: :ruby

      def nested_warnings(*)
        super.uniq
      end

      def inspect
        "#<Travis::Yaml:#{super}>"
      end
    end
  end
end