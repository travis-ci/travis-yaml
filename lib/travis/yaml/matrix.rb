require 'delegate'

module Travis::Yaml
  class Matrix < DelegateClass(Array)
    EXPAND_KEYS = [
      :compiler, :gemfile, :ghc, :go, :jdk, :lein, :node_js, :otp_release,
      :perl, :php, :python, :ruby, :scala, :xcode_scheme, :xcode_sdk, :os
    ]

    KEYS = EXPAND_KEYS + [:env]

    class Entry < DelegateClass(Nodes::Root)
      attr_reader :env, :matrix_attributes

      def initialize(root, matrix_attributes)
        super(root)

        @matrix_attributes = matrix_attributes
        @env               = Nodes::Env.new(self)
        inherited_env      = root.env.global if root.env
        @env.global        = [matrix_attributes[:env], *inherited_env].compact
      end

      EXPAND_KEYS.each do |key|
        define_method(key) { @matrix_attributes.fetch(key, super()) }
      end

      def inspect
        "#<#{self.class}: #{matrix_attributes}>"
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
        first, *rest = axes.map { |k| values_for(k) || [] }
        entries      = Array(first).product(*rest).map { |list| Hash[axes.zip(list)] }
        if m = root.matrix
          entries.delete_if { |e| m.exclude.any? { |p| p.all? { |k,v| e[k.to_sym] == v } } } if m.exclude
          m.include.each { |i| entries << Hash[axes.map { |k| [k, i[k]] }] } if m.include
        end
        entries.map! { |attributes| Entry.new(root, attributes) }
        entries.any? ? entries : [root]
      end
    end

    def values_for(key)
      return root[key] unless key == :env
      root.env.matrix if root.env
    end
  end
end
