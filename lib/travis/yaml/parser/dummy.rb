module Travis::Yaml
  module Parser
    module Dummy
      def self.parses?(value)
        value.is_a? Travis::Yaml::Nodes::Node
      end

      def self.parse(value)
        value
      end
    end
  end
end
