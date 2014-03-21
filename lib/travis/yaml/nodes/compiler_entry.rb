module Travis::Yaml
  module Nodes
    class CompilerEntry < FixedValue
      ignore_case
      default :gcc
      value :gcc, :clang, :"g++" => :gcc, :"clang++" => :clang
    end
  end
end
