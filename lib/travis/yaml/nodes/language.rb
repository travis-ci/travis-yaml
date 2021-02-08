module Travis::Yaml
  module Nodes
    class Language < FixedValue
      ignore_case
      default :ruby

      value :c, :cpp, :clojure, :d, :dart, :erlang, :go, :groovy, :haskell, :haxe, :java,
            :node_js, :"objective-c", :ruby, :rust, :python, :perl, :php, :scala,
            :android, :crystal, :csharp, :smalltalk
      value dartlang: :dart, jvm: :java, javascript: :node_js, node: :node_js,
            nodejs: :node_js, golang: :go, objective_c: :"objective-c",
            obj_c: :"objective-c", objc: :"objective-c"
      value "c++" => :cpp, "node.js" => :node_js, "obj-c" => :"objective-c"
      value :generic, bash: :generic, sh: :generic, shell: :generic, minimal: :generic

      def default_os
        value == "objective-c" ? "osx" : OSEntry.default
      end
    end
  end
end
