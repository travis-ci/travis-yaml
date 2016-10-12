module Travis::Yaml
  module Patch
    module Config
      class Group < Struct.new(:config)
        def apply
          config.group = 'stable' unless config.group
          config
        end
      end
    end
  end
end
