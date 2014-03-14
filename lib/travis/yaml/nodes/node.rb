module Travis::Yaml
  module Nodes
    class Node
      def self.has_default?
        false
      end

      attr_accessor :partent
      def initialize(parent = nil)
        @nested_warnings = []
        @parent          = parent
        prepare
      end

      def warngings?
        warnings.any?
      end

      def errors?
        errors.any?
      end

      def warnings
        @warnings ||= []
      end

      def nested_warning(message, *prefix)
        @nested_warnings << [prefix, message]
      end

      def nested_warnings(*prefix)
        messages  = errors + warnings
        prefixed  = messages.map { |warning| [prefix, warning] }
        prefixed += @nested_warnings.map { |p, w| [prefix + p, w] }
        prefixed
      end

      def errors
        @errors ||= []
      end

      def warning(message, *params)
        warnings << message % params
      end

      def error(message, *params)
        errors << message % params
      end

      def prepare
      end

      def verify
      end

      def deep_verify
        verify
      end

      def visit_unexpected(visitor, value, message = nil)
        error(message || "unexpected %p", value)
      end

      def visit_mapping(visitor, value)
        error("unexpected mapping")
      end

      def visit_pair(visitor, key, value)
        error("unexpected pair")
      end

      def visit_scalar(visitor, type, value, implicit = true)
        error("unexpected scalar") unless type == :null
      end

      def visit_sequence(visitor, value)
        error("unexpected sequence")
      end

      def visit_child(visitor, value)
        error("unexpected child")
      end

      def respond_to_missing?(method, include_private = false)
        __getobj__.respond_to?(method, false)
      end

      def method_missing(method, *args, &block)
        return super unless __getobj__.respond_to?(method)
        __getobj__.public_send(method, *args, &block)
      end
    end
  end
end