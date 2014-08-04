$:.unshift File.expand_path("../lib", __FILE__)
require "travis/yaml/version"

Gem::Specification.new do |s|
  s.name                  = "travis-yaml"
  s.version               = Travis::Yaml::VERSION
  s.author                = "Travis CI GmbH"
  s.email                 = "contact@travis-ci.com"
  s.homepage              = "https://github.com/travis-ci/travis-yaml"
  s.summary               = %q{parses your .travis.yml}
  s.description           = %q{parses and validates your .travis.yml, fast and secure}
  s.license               = 'MIT'
  s.files                 = `git ls-files`.split("\n")
  s.test_files            = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables           = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_path          = 'lib'
  s.required_ruby_version = '>= 1.9.3'

  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'safe_yaml', '~> 1.0.1'
end
