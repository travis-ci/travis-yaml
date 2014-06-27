require 'bundler/setup'
require 'travis/yaml'

module Travis::Yaml
  def spec(**options)
    Nodes::Root.spec(**options)
  end

  module Nodes
    TEMPLATE_VARS     = Notifications::Template::VARIABLES.map { |v| "`%{#{v}}`"}.join(", ")
    SPEC_DESCRIPTIONS = {
      Stage                   => "Commands that will be run on the VM.",
      Notifications::Template => "Strings will be interpolated. Available variables: #{TEMPLATE_VARS}.",
      %w[gemfile]             => "Gemfile(s) to use.",
      "gemfile"               => "Gemfile to use."
    }

    TYPES = {
      binary: 'binary string',
      bool:   'boolean value',
      float:  'float value',
      int:    'integer value',
      null:   'null value',
      str:    'string',
      time:   'time value',
      secure: 'encrypted string',
      regexp: 'regular expression'
    }

    class Node
      def self.spec_description(*prefix)
        description = SPEC_DESCRIPTIONS[prefix] || SPEC_DESCRIPTIONS[prefix.last]
        ancestors.each { |a| description ||= SPEC_DESCRIPTIONS[a] }
        description
      end

      def self.spec_format(*)
      end

      def self.spec(*prefix, **options)
        options[:experimental] ||= false
        options[:required]     ||= false
        [{ key: prefix, description: spec_description(*prefix), format: spec_format, **options }]
      end
    end

    class Scalar
      def self.spec_format(append = "", *)
        formats = cast.any? ? cast : [default_type]
        formats.map { |f| TYPES[f] ? TYPES[f]+append : f.to_s }.join(', ').gsub(/, ([^,]+)$/, ' or \1')
      end
    end

    class Version
      def self.spec_description(*prefix)
        super || "`#{prefix.last}` version to use."
      end
    end

    class VersionList
      def self.spec_description(*prefix)
        super || "List of `#{prefix.last}` versions to use."
      end
    end

    class FixedValue
      def self.spec_description(*prefix)
        super || begin
          list = valid_values.map { |v| "`#{v}`#{" (default)" if default == v.to_s}" }.join(', ').gsub(/,([^,]+)$/, ' or\1')
          if aliases.any?
            alias_list = aliases.map { |k,v| "`#{k}` for `#{v}`" }.join(', ').gsub(/,([^,]+)$/, ' or\1')
            list += "; or one of the known aliases: #{alias_list}"
          end
          "Value has to be #{list}. Setting is#{" not" if ignore_case?} case sensitive."
        end
      end
    end

    class Notifications::Notification
       def self.spec_format_prefix(input, append = "")
         super(input)
         input << ", or boolean value#{append}"
       end
    end

    class Notifications::Flowdock
       def self.spec_format_prefix(input, append = "")
         input << ", or string#{append}, encrypted string#{append}, or boolean value#{append}"
       end
    end

    class Sequence
      def self.spec_format(append = "", children = true, *)
        return unless type.spec_format
        format = "list of " << type.spec_format("s")
        format << "; or a single " << type.spec_format if children
        format
      end

      def self.spec(*prefix, **options)
        specs = super
        specs += type.spec(*prefix, '[]') unless type <= Scalar and not type < FixedValue
        specs
      end
    end

    class Root
      def self.spec(*)
        super[1..-1].sort_by { |e| e[:key] }
      end
    end

    class OpenMapping
      def self.spec(*prefix, **options)
        super + default_type.spec(*prefix, '*')
      end
    end

    class Mapping
      def self.spec_format(append = "", *)
        format = "key value mapping#{append}"
        spec_format_prefix(format, append)
        format
      end

      def self.spec_format_prefix(input, append = "")
        input << ", or #{subnode_for(prefix_sequence).spec_format('s', prefix_sequence != prefix_scalar)}" if prefix_sequence
        input << ", or #{subnode_for(prefix_scalar).spec_format(append)}" if prefix_scalar and prefix_scalar != prefix_sequence
      end

      def self.default_spec_description
        "a key value map"
      end

      def self.spec_options(key, **options)
        if self < LanguageSpecific and languages = LanguageSpecific::LANGUAGE_SPECIFIC[key.to_sym]
          languages = languages.map { |v| "`#{v}`#{" (default)" if v.to_s == 'ruby'}" }.join(', ').gsub(/,([^,]+)$/, ' or\1')
        end
        { required: required.include?(key), experimental: experimental.include?(key), languages:  languages }
      end

      def self.spec_aliases(*prefix, **options)
        aliases.map { |k,v| { key: [*prefix, k], alias_for: [*prefix, v], **spec_options(k, **options) } }
      end

      def self.spec(*prefix, **options)
        specs = mapping.sort_by(&:first).inject(super) { |l, (k,v)| l + v.spec(*prefix, k, **spec_options(k, **options)) }
        specs + spec_aliases(*prefix, **options)
      end
    end
  end
end

def self.format_name(key)
  key.join('.').gsub('.[]', '[]')
end

def self.format_link(key)
  key.join.gsub('[]', '')
end

content = <<-MARKDOWN
## The `.travis.yml` Format
Here is a list of all the options understood by travis-yaml.

Note that stricitly speaking Travis CI might not have the same understanding of these as travis-yaml has at the moment, since travis-yaml is not yet being used.

### Available Options
MARKDOWN

Travis::Yaml.spec.each do |entry|
  content << "#### `" << format_name(entry[:key]) << "`\n"
  content << "**This setting is only relevant if [`language`](#language) is set to #{entry[:languages]}.**\n\n" if entry[:languages]
  content << "**This setting is required!**\n\n" if entry[:required]
  content << "**This setting is experimental and might be removed!**\n\n" if entry[:experimental]
  if other = entry[:alias_for]
    content << "Alias for " << "[`#{format_name(other)}`](##{format_link(other)})." << "\n\n"
  else
    content << entry[:description] << "\n\n" if entry[:description]
    content << "**Expected format:** " <<  entry[:format].capitalize << ".\n\n" if entry[:format]
  end
end

content << <<-MARKDOWN
## Generating the Specification

This file is generated. You currently update it by running `play/spec.rb`.
MARKDOWN

File.write('SPEC.md', content)