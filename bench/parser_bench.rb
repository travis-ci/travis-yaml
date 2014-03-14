require 'bundler/setup'
require 'benchmark'
require 'psych'
require 'safe_yaml/load'
require 'travis/yaml'

parsers = [Psych, SafeYAML, Travis::Yaml]
content = <<-YAML
# from rails/rails
script: 'ci/travis.rb'
before_install:
  - travis_retry gem install bundler
  - "rvm current | grep 'jruby' && export AR_JDBC=true || echo"
rvm:
  - 1.9.3
  - 2.0.0
  - 2.1.1
  - rbx-2
  - jruby
env:
  - "GEM=railties"
  - "GEM=ap,am,amo,as,av"
  - "GEM=ar:mysql"
  - "GEM=ar:mysql2"
  - "GEM=ar:sqlite3"
  - "GEM=ar:postgresql"
matrix:
  allow_failures:
    - rvm: rbx-2
    - rvm: jruby
  fast_finish: true
notifications:
  email: false
  irc:
    on_success: change
    on_failure: always
    channels:
      - "irc.freenode.org#rails-contrib"
  campfire:
    on_success: change
    on_failure: always
bundler_args: --path vendor/bundle --without test
services:
  - memcached
YAML

GC.disable
Benchmark.bmbm do |x|
  parsers.each do |parser|
    x.report(parser.inspect) do
      500.times { parser.load(content) }
    end
  end
end