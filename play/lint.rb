# Usage: ruby play/travis.rb [FILE]
# Will output any error/warnings
require 'bundler/setup'
require 'travis/yaml'

file    = ARGV[0] || ".travis.yml"
content = File.read(file)
Travis::Yaml.parse!(content, file)
