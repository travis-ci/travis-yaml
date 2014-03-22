module Travis::Yaml
  module Nodes
    class DeployConditions < Mapping
      include LanguageSpecific
      map :jdk, :node, :perl, :php, :python, :ruby, :scala, :node, to: Version
      map :rvm, to: :ruby
      map :node_js, to: :node
      map :repo, :branch, :condition, to: Scalar[:str]
      map :all_branches, :tags, to: Scalar[:bool]
      prefix_scalar :branch
    end
  end
end