module Travis::Yaml
  module Nodes
    class Dist < FixedValue
      ignore_case
      # TODO does nothing?
      # default :precise
      value :precise, :trusty, :osx
    end
  end
end
