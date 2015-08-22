module Travis::Yaml
  module Nodes
    class VersionList < Sequence
      def self.[](expression)
        Class.new(self) { type Version[expression] }
      end

      type Version
    end
  end
end
