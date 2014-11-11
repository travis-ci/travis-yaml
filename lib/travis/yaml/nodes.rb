module Travis::Yaml
  module Nodes
    def self.[](key)
      return key if key.respond_to? :new
      name = constants.detect { |c| c.downcase == key }
      raise ArgumentError, "unknown node type %p" % key unless name
      const_get(name)
    end

    require 'travis/yaml/nodes/node'
    require 'travis/yaml/nodes/scalar'
    require 'travis/yaml/nodes/fixed_value'
    require 'travis/yaml/nodes/sequence'
    require 'travis/yaml/nodes/mapping'
    require 'travis/yaml/nodes/open_mapping'
    require 'travis/yaml/nodes/language_specific'
    require 'travis/yaml/nodes/version'
    require 'travis/yaml/nodes/version_list'
    require 'travis/yaml/nodes/git'
    require 'travis/yaml/nodes/bundler_args'
    require 'travis/yaml/nodes/stage'
    require 'travis/yaml/nodes/deploy_conditions'
    require 'travis/yaml/nodes/deploy_entry'
    require 'travis/yaml/nodes/deploy'
    require 'travis/yaml/nodes/language'
    require 'travis/yaml/nodes/compiler_entry'
    require 'travis/yaml/nodes/compiler'
    require 'travis/yaml/nodes/os_entry'
    require 'travis/yaml/nodes/os'
    require 'travis/yaml/nodes/virtual_env'
    require 'travis/yaml/nodes/ruby'
    require 'travis/yaml/nodes/jdk'
    require 'travis/yaml/nodes/env'
    require 'travis/yaml/nodes/matrix'
    require 'travis/yaml/nodes/notifications'
    require 'travis/yaml/nodes/branches'
    require 'travis/yaml/nodes/cache'
    require 'travis/yaml/nodes/addons'
    require 'travis/yaml/nodes/android'
    require 'travis/yaml/nodes/dist'
    require 'travis/yaml/nodes/group'
    require 'travis/yaml/nodes/root'
  end
end
