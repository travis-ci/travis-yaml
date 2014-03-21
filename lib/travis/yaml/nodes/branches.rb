module Travis::Yaml
  module Nodes
    class Branches < Mapping
      class Matcher < Sequence
        type Scalar[:str, :regexp]
      end

      map :only, :except, to: Matcher
      auto_prefix :only
    end
  end
end
