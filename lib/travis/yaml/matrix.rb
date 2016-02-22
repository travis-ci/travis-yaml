require 'delegate'

module Travis::Yaml
  class Matrix < DelegateClass(Array)
    EXPAND_KEYS = [
      :compiler, :crystal, :d, :dart, :gemfile, :ghc, :go, :haxe, :jdk, :lein,
      :node_js, :otp_release, :perl, :php, :python, :ruby, :scala, :xcode_scheme,
      :xcode_sdk, :os , :smalltalk
    ]

    KEYS = EXPAND_KEYS + [:env]

    class Entry < DelegateClass(Nodes::Root)
      attr_reader :matrix_attributes
      def initialize(root, matrix_attributes)
        @matrix_attributes   = matrix_attributes
        normal_attributes    = matrix_attributes.select { |key| key != :env }
        generated_root       = root.with_value(normal_attributes)
        if matrix_attributes[:env]
          generated_root.env.global = Travis::Yaml::Nodes::Env::List.new(generated_root.env)
          generated_root.env.global.add_value! root.env.global if root.env.global
          generated_root.env.global.add_value! matrix_attributes[:env]
          generated_root.env.mapping.delete "matrix"
        end
        super(generated_root)
      end
    end

    attr_reader :root

    def initialize(root)
      @root = root
      super(entries)
    end

    def axes
      @axes ||= KEYS.select do |key|
        next true if values_for(key) and values_for(key).size > 1
        root.matrix.include.any? { |i| i[key] } if root.matrix and root.matrix.include
      end
    end

    def entries
      @entries ||= begin
        first, *rest = axes.map { |k| values_for(k) || [nil] }
        entries      = Array(first).product(*rest).map { |list| Hash[axes.zip(list)] }
        if m = root.matrix
          entries.delete_if { |e| m.exclude.any? { |p| p.all? { |k,v| e[k.to_sym] == v } } } if m.exclude
          m.include.each { |i| entries << Hash[axes.map { |k| [k, i[k]] }] } if m.include
        end
        entries.map! { |attributes| Entry.new(root, attributes) }
        entries.any? ? entries : [Entry.new(root, {})]
      end
    end

    def values_for(key)
      return root[key] unless key == :env
      root.env.matrix if root.env
    end
  end
end
