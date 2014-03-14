module Travis::Yaml
  module Nodes
    class DeployEntry < OpenMapping
      map :provider, to: Scalar, required: true
      map :on, to: DeployConditions
    end
  end
end