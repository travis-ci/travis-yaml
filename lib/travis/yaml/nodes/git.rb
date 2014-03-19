module Travis::Yaml
  module Nodes
    class Git < Mapping
      map :depth,      to: Scalar[:int]
      map :submodules, to: Scalar[:bool]
      map :strategy,   to: FixedValue[:clone, :tarball]
    end
  end
end