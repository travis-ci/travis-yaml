module Travis::Yaml
  module Nodes
    class Android < Mapping
      map :components, :licenses, to: VersionList
    end
  end
end
