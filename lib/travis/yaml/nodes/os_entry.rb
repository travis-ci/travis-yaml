module Travis::Yaml
  module Nodes
    class OSEntry < FixedValue
      ignore_case
      default :linux
      value :linux, ubuntu: :linux
      value :osx, mac: :osx, macos: :osx
    end
  end
end