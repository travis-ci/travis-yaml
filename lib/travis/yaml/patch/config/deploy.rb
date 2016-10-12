module Travis::Yaml
  module Patch
    module Config
      class Deploy < Struct.new(:config)
        def apply?
          config['deploy']
        end

        def apply
          deploy = config.delete('deploy')
          config['addons'] ||= Nodes::Addons.new(config)
          config['addons']['deploy'] = deploy
          config
        end
      end
    end
  end
end
