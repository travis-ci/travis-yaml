module Travis::Yaml
  module Nodes
    class Language < FixedValue
      ignore_case
      default :ruby

      value :c, :cpp, :clojure, :erlang, :go, :groovy, :haskell, :java, :node_js,
            :"objective-c", :ruby, :python, :perl, :php, :scala
      value jvm: :java, javascript: :node_js, node: :node_js, nodejs: :node_js,
            objective_c: :"objective-c", obj_c: :"objective-c", objc: :"objective-c"
      value "c++" => :cpp, "node.js" => :node_js, "obj-c" => :"objective-c"

      def default_os
        value == "objective-c" ? :osx : OSEntry.default
      end
    end
  end
end