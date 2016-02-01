# Travis Configuration Parser

## What is this?

This project is a library for loading Travis CI build configuration.

It can create a configuration both from a normal Ruby Hash or a YAML string.
These config objects generally behave like normal primitives (hashes, arrays, etc).

``` ruby
require 'travis/yaml'

config = Travis::Yaml.parse('language: ruby')
config = Travis::Yaml.parse(language: 'ruby')

config[:language] # ruby
config.language   # ruby

# using parse! instead of parse will print out warnings
Travis::Yaml.parse! deploy: []
# .travis.yml: missing key "language", defaulting to "ruby"
# .travis.yml: value for "deploy" section is empty, dropping

# have it generate the build matrix for you
Travis::Yaml.matrix('rvm: [jruby, 2.0.0]').each do |matrix_entry|
  puts matrix_entry.ruby
end
```

## Why use it?

* **Prevents code execution.** Instead of deserializing arbitrary Ruby objects, it only deserializes primitive objects. To go even further, in contrast to SafeYAML, it only deserializes primitive objects that are expected for a certain part of the configuration.
* **Prevents memory leaks.** Internally, only expected values are stored in the data structure, discarding any additional data. No user input is converted to symbols (which would allow a memory based DoS attack).
* **Normalization is happening in one place.** Travis CI currently does config normalization in many different parts of its infrastructure, making it tedious to determine supported input formats and the resulting internal structure.
* **Explicit structure.** Due to the explicit configuration structure, exceptions throughout the system can be greatly reduced, since the configuration will not contain unexpected objects.
* **Forgiving about user input.** The parser knows the expected structure and can therefore automatically map some malformed input onto that structure. For instance, `node: 1.10` does not get converted to `node: 1.1` internally, because travis-yaml knows to expect a string here rather than a float.
* **Built-in support for encrypted values**, making it easier to support these in different parts of the system and never leak the decrypted form if configuration is being serialized.
* **Extensive warning and error handling**, making it possible to use this library for linting and also to display such warnings when running a build.
* **Performance.** Using travis-yaml to load a configuration from a YAML string is slightly faster than using psych directly and significantly faster than using safeyaml.
* **Compatibility.** This library is written in a way to not only be fully compatible with the current .travis.yml format, but also with the configuration data in the current Travis database and with the code interacting with the configuration data (for instance in travis-build).
* **Extensibility.** The configuration structure is easily extended.
* **Pluggable parser.** It is easy to write a new parser. This would be useful for instance for the Travis CI command line client, where one could imagine a parser for the small subset of the YAML format that is commonly in use. This would for instance allow to write a parser and serializer able to preserve comments and indentation when modifying the contents of the .travis.yml.

## What is missing?

* Serialization

## External API

### Loading a config

``` ruby
config = Travis::Yaml.parse('language: ruby') # parse from a yaml string
config = Travis::Yaml.parse(language: "ruby") # parse from Ruby object
```

For Psych/YAML compatibility, `parse` is also aliased to `load`.

### Convenience

Nodes generally behave like normal Ruby objects. Mappings accept both symbols and strings as keys. Known fields on mappings are exposed as methods.

``` ruby
puts config.language
puts config[:language]
puts config['language']
```

### Warnings and errors

* **errors** are actual parse errors, parent elements should discard elements with errors.
* **warnings** are general warnings for an element, with the element still being usable. These do not include warnings for child elements (though an error in a child element becomes a warning for its immediate parent).
* **nested warnings** include warnings for the whole tree, they also come with key prefix (array of strings) to identify the position the error occured at.

``` ruby
Travis::Yaml.parse("foo: bar").nested_warnings.each do |key, warning|
  puts "#{key.join('.')}: #{warning}"
end

# will print nested warnings to stderr, will raise on top level error
Travis::Yaml.parse! "foo: bar"
```

### Secure Variables

Secure variables are stored as `Travis::Yaml::SecureString` internally. A secure string has at least an `encrypted_string` or a `decrypted_string`, or both.

You can use `decrypt`/`encrypt` with a block to generate the missing string:

``` ruby
secret = Travis::Yaml::SecureString.new("foo")

secret.encrypted_string # => "foo"
secret.decrypted_string # => nil
secret.encrypted?       # => true
secret.decrypted?       # => false

secret.decrypt { |string| string.upcase }

secret.encrypted_string # => "foo"
secret.decrypted_string # => "FOO"
secret.encrypted?       # => true
secret.decrypted?       # => true
```

To avoid having to walk the whole structure manually or hardcoding the values to decrypt, these methods are also exposed on any node:

``` ruby
config = Travis::Yaml.load 'env: { secure: foo }'
config.decrypted? # => false

config.decrypt { |string| string.upcase }
config.decrypted?                        # => true
config.env.matrix.first.decrypted_string # => "FOO"
```

This can even be done right with the parse step:

``` ruby
content = File.read('.travis.yml')
Travis::Yaml.parse! content do |config|
  config.decrypt { |string| string.upcase }
end
```

### Serialization

A travis-yaml document can be serialized to a few other formats via the `serialize` method:

``` ruby
pp   config.serialize(:ruby)
puts config.serialize(:json, pretty: true)
```

Serializer | Descriptions                                                      | Options
-----------|-------------------------------------------------------------------|---------
`ruby`     | Corresponding Ruby objects, secure values will be `SecureString`s | `secure`, `symbol_keys`
`legacy`   | Format compatible with Travis CI's old `fetch_config` service     | `secure`, `symbol_keys`
`json`     | Serialize as JSON, parsable via `Travis::Yaml.load`               | `secure`, `pretty`
`yaml`     | Serialize as YAML, parsable via `Travis::Yaml.load`               | `secure`, `symbol_keys`, `indentation`, `line_width`, `canonical`, `avoid_tags`

The `secure` option can be set to `:decrypted` or `:encrypted`, enforcing the decrypted or encrypted form of secure strings to be serialized. In some serializations, this might lead to secure strings being mapped to normal strings if set to `:decrypted`.

## Defining Structure

Good starting points for getting into the code are the [root](lib/travis/yaml/nodes/root.rb) node and the [language](lib/travis/yaml/nodes/language.rb) node.

A parsed configuration is very similar to a syntax tree. To create a new node type, you should inherit from one of the abstract types. Internal vocabulary is taken from the YAML spec rather than the Ruby names (ie, sequence vs array, mapping vs hash).

### Scalar Values

Most of the time, scalar values are just strings. In fact, if you create a new scalar node class and don't specify and other supported type, it will treat everything as string.

``` ruby
module Travis::Yaml::Nodes
  class Example < Scalar
  end
end
```

This will parse `foo` to `"foo"` and `1.10` to `1.10`. This will also generate a warning and discard values like `!float 1.10`.

#### Value Types

You can also allow other types and change the default type unsupported implicit types are cast to.

``` ruby
module Travis::Yaml::Nodes
  class Example < Scalar
    cast :str, :binary, :int
    default_type :int
  end
end
```

Available types are `str`, `binary`, `bool`, `float`, `int`, `time`, `regexp`, `secure` and `null`.

#### Default Value

It is also possible to give a scalar a default value.

``` ruby
module Travis::Yaml::Nodes
  class Example < Scalar
    default_value "example"
  end
end
```

This is handy when using it for a required entry in a mapping (for instance, `language` is required, but has a default).

#### Fixed Value Set

For entries that have a well defined set of values, you can inherit from `FixedValue`:

``` ruby
module Travis::Yaml::Nodes
  class Example < FixedValue
    ignore_case

    default_value :example
    value :foo, :bar, baz: :bar
  end
end
```

This will, for example, map `FOO` to `"foo"`, `baz` to `"bar"`, and `blah` to `"example"` (and generate a warning about `blah` being not supported).

#### Shorthands

There are shorthands for creating `Scalar` and `FixedValue` subclasses:

``` ruby
module Travis::Yaml::Nodes
  class Example < Map
    map :foo, to: Scalar[:int]
    map :bar, to: FixedValue[:foo, :bar]
  end
end
```

### Sequences

Sequences correspond to Ruby arrays. If you pass in a scalar or mapping instead of a sequence, it will be treated as if it was a sequence with a single entry of that value.

``` ruby
module Travis::Yaml::Nodes
  class ExampleList < Sequence
    type ExampleValue # node type, defaults to Scalar
  end
end
```

### Mappings

Mappings correspond to hashes in Ruby.

``` ruby
module Travis::Yaml::Nodes
  class ExampleMapping < Mapping
    # map the value for the "example" key to an Example node
    # map the value for the "other" key to an Other node
    map :example, :other

    # map the values for "foo" and "bar" to a Scalar
    map :foo, :bar, to: Scalar

    # map "list" to a Sequence, keep it even if it's empty
    map :list, to: Sequence, drop_empty: false

    # require "setting" to be present
    map :setting, required: true

    # make "option" an alias for "setting"
    map :option, to: :setting

    # if a scalar is passed in instead of a mapping, treat it as
    # the value of "setting" ("foo" becomes { setting: "foo" })
    prefix_scalar :setting
  end
end
```

#### Open Mappings

Sometimes it is not possible to define all available keys for a mapping. You can solve this by using an open mapping:

``` ruby
module Travis::Yaml::Nodes
  class ExampleMapping < OpenMapping
    # node type for entries not specified (defaults to Scalar)
    default_type ExampleValue

    # map "setting" to Setting node, make it a requirement
    map :setting, required: true
  end
end
```

You can also limit the possible keys by overriding `accept_key?`.

``` ruby
module Travis::Yaml::Nodes
  class ExampleMapping < OpenMapping
    default_type ExampleValue

    def accept_key?(key)
      key.start_with? "example_"
    end
  end
end
```

### Additional Verification

Besides the generated warnings, validations and normalizations inherent to the structure, you can define your own checks and normalizations by overriding the `verify` method.

``` ruby
module Travis::Yaml::Nodes
  class Example < Scalar
    def verify
      if value == "foo"
        warning "foo is deprecated, using bar instead"
        self.value = "bar"
      end
      super
    end
  end
end
```

The `warning` method will generate track a warning, so it can be presented to the user later on. The `error` method will lead to the node being removed from its parent node. It will also propagate the error message as a warning in the parent node.

### Nested Warnings

When reflecting upon a node, `warnings` and `errors` will only contain the messages for that specific node. To get all the warnings for the entire tree, use `nested_warnings`, which will also give you the path (as array of strings).

``` ruby
config.nested_warnings.each do |path, message|
  p path      # ["my", "example", "key"]
  p message   # "this is the warning"
end
```

## Requirements

This project requires Ruby 1.9.3 or 2.0.0 and Psych ~> 2.0 (part of the stdlib).
