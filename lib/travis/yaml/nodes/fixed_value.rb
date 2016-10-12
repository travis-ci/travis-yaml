module Travis::Yaml
  module Nodes
    class FixedValue < Scalar
      def self.[](*values)
        Class.new(self) { value(*values) }
      end

      def self.default(value = nil)
        value &&= value.to_s
        super(value)
      end

      def self.ignore_case?
        @ignore_case ||= false
      end

      def self.ignore_case
        @ignore_case = true
      end

      def self.valid_values
        @valid_values ||= superclass.respond_to?(:valid_values) ? superclass.valid_values.dup : []
      end

      def self.aliases
        @aliases ||= superclass.respond_to?(:aliases) ? superclass.aliases.dup : {}
      end

      def self.map_value(value)
        value = value.to_s
        if ignore_case?
          all_values = valid_values + aliases.keys
          value      = all_values.detect { |supported| supported.downcase == value.downcase }
        end
        value &&= aliases.fetch(value, value)
        value if valid_values.include? value
      end

      def self.value(*list)
        list.each do |value|
          if value.respond_to? :each_pair
            value.each_pair { |aka, proper| aliases[aka.to_s] = proper.to_s }
          else
            valid_values << value.to_s
          end
        end
      end

      def value=(value)
        if mapped = self.class.map_value(value)
          super(mapped)
        elsif self.value
          warning "illegal value %p, defaulting to %p", value, self.value
        elsif value
          error "illegal value %p", value
        end
      end
    end
  end
end
