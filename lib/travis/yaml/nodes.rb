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
    require 'travis/yaml/nodes/stage'
    require 'travis/yaml/nodes/deploy_conditions'
    require 'travis/yaml/nodes/deploy_entry'
    require 'travis/yaml/nodes/deploy'
    require 'travis/yaml/nodes/language'
    require 'travis/yaml/nodes/ruby'
    require 'travis/yaml/nodes/root'
  end
end
