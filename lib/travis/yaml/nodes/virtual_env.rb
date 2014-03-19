module Travis::Yaml
  module Nodes
    class VirtualEnv < Mapping
      map :system_site_packages, to: Scalar[:bool]
    end
  end
end