require 'shellwords'

module Travis::Yaml
  module Nodes
    class Env < Mapping
      class Variables < Scalar
        cast :str, :secure

        def visit_mapping(visitor, value)
          self.value = ""
          visitor.apply_mapping(self, value)
        end

        def visit_key_value(visitor, key, value)
          key  = visitor.generate_key(self, key)
          node = Scalar.new
          visitor.accept(node, value)

          if node.errors?
            warning "dropping %p: %s", key, value.errors.join(', ')
          else
            self.value << " " unless self.value.empty?
            self.value << "#{key}=#{Shellwords.escape(value.value)}"
          end
        end
      end

      class List < Sequence
        type Variables
      end

      map :global, :matrix, to: List
      auto_prefix :matrix
    end
  end
end