module Travis::Yaml
  module Nodes
    class Cache < Mapping
      map :apt, :bundler, :cocoapods, :pip, :ccache, to: Scalar[:bool]
      map :edge, to: Scalar[:bool], experimental: true
      map :directories, to: Sequence

      def visit_scalar(visitor, type, value, implicit = true)
        case type
        when :bool
          visit_key_value(visitor, :bundler,   value)
          visit_key_value(visitor, :apt,       value)
          visit_key_value(visitor, :cocoapods, value)
          visit_key_value(visitor, :pip, value)
          visit_key_value(visitor, :ccache, value)
        when :str
          key = visitor.generate_key(self, value)
          self[key] = true
        else
          super
        end
      end

      def visit_sequence(visitor, value)
        visitor.apply_sequence(self, value)
      end

      def visit_child(visitor, value)
        visit_scalar(visitor, :str, value)
      end
    end
  end
end
