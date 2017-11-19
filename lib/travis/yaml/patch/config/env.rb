module Travis::Yaml
  module Patch
    module Config
      class Env < Struct.new(:config)
        def apply
          config
        end
      end
    end
  end
end
