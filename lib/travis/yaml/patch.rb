require 'travis/yaml/patch/config/deploy'
require 'travis/yaml/patch/config/dist'
require 'travis/yaml/patch/config/env'
require 'travis/yaml/patch/config/group'

module Travis::Yaml
  module Patch
    PATCHES = [Config::Deploy, Config::Dist, Config::Env, Config::Group]

    def self.apply(config)
      PATCHES.inject(config) do |config, patch|
        patch = patch.new(config)
        config = patch.apply if !patch.respond_to?(:apply?) || patch.apply?
        config
      end
    end
  end
end
