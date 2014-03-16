module Travis::Yaml
  module Nodes
    class DeployEntry < OpenMapping
      prefix_scalar :provider
      map :provider, to: Scalar, required: true
      map :on, to: DeployConditions
    end
  end
end