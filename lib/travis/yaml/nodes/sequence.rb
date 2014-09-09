module Travis::Yaml
  module Nodes
    class Sequence < Node
      attr_reader :children
      alias_method :__getobj__, :children

      def self.[](node_type)
        node_type = Scalar[node_type] unless node_type.is_a? Node
        Class.new(self) { type(node_type) }
      end

      def self.type(identifier = nil)
        @type = Nodes[identifier] if identifier
        @type ||= superclass.respond_to?(:type) ? superclass.type : Scalar
      end

      def prepare
        @children = []
      end

      def visit_sequence(visitor, value)
        visitor.apply_sequence(self, value)
      end

      def visit_scalar(visitor, type, value, implicit = true)
        visit_child(visitor, value) if type != :null
      end

      def visit_mapping(visitor, value)
        visit_child(visitor, value)
      end

      def visit_child(visitor, value)
        child = self.class.type.new(self)
        visitor.accept(child, value)
        @children << child
      end

      def nested_warnings(*prefix)
        @children.inject(super) do |list, value|
          list = value.nested_warnings(*prefix) + list
        end
      end

      def ==(other)
        other = other.children if other.is_a? Sequence
        if other.respond_to? :to_a and other.to_a.size == children.size
          children.zip(other.to_a).all? { |a, b| a == b }
        else
          identifier == other
        end
      end

      def empty?
        @children.empty?
      end

      def inspect
        identifier.inspect
      end

      def to_s
        identifier.to_s
      end

      def identifier
        @children.size == 1 ? @children.first : @children
      end

      def verify
        verify_children
        super
      end

      def verify_children
        @children.delete_if do |child|
          next unless child.errors?
          child.errors.each { |message| warning(message) }
          true
        end
      end

      def deep_verify
        @children.each(&:deep_verify)
        super
      end

      def each_scalar(type = nil, &block)
        return enum_for(:each_scalar, type) unless block
        @children.each { |c| c.each_scalar(type, &block) }
      end

      def with_value(value)
        return value.dup if value.is_a? self.class
        value = value.children if value.is_a? Sequence
        value = value.value while value.is_a? Scalar
        Parser::Ruby.new(Array(value)).parse self.class.new(parent)
      end

      def with_value!(value)
        children.replace with_value(value).children
      end

      def add_value(value)
        added = with_value(self)
        added.add_value!(value)
        added
      end

      def add_value!(value)
        children.concat(with_value(value).children)
      end

      protected

        def dup_values
          @children = @children.map { |child| child.dup }
          self
        end
    end
  end
end