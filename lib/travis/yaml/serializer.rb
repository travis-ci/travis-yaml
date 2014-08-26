module Travis::Yaml
  module Serializer
    NotSupportedError ||= Class.new(ArgumentError)
    require 'travis/yaml/serializer/generic'
    require 'travis/yaml/serializer/ruby'
    require 'travis/yaml/serializer/legacy'
    require 'travis/yaml/serializer/json'
    require 'travis/yaml/serializer/yaml'

    def self.[](key)
      return key if key.respond_to? :serialize
      name = constants.detect { |c| c.downcase == key }
      raise ArgumentError, "unknown serializer %p" % key unless name
      const_get(name)
    end
  end
end
