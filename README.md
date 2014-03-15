# Travis Configuration Parser

**This is work in progress, it is not actually in use yet.**

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
```

## Why use it?

* **Prevents code execution.** Instead of deserializing arbitrary Ruby objects, it only deserializes primitive objects. To go even further, in contrast to SafeYAML, it only deserializes primitive objects that are expected for a certain part of the configuration.
* **Prevents memory leaks.** Internally, only expected values are stored in the data structure, discarding any additional data. No user input is converted to symbols (which would allow a memory based DoS attack).
* **Normalization is happening in one place.** Travis CI currently does config normalization in many different parts of its infrastructure, making it tedious to determine supported input formats and the resulting internal structure.
* **Explicit structure.** Due to the explicit configuration structure, exceptions throughout the system can be greatly reduced, since the configuration will not contain unexpected objects.
* **Forgiving about user input.** The parser knows the expected structure and can therefore automatically map some malformed input onto that structure.
* **Built-in support for encrypted values**, making it easier to support these in different parts of the system and never leak the decrypted form if configuration is being serialized.
* **Extensive warning and error handling**, making it possible to use this library for linting and also to display such warnings when running a build.
* **Performance.** Using travis-yaml to load a configuration from a YAML string is slightly faster than using psych directly and significantly faster than using safeyaml.
* **Compatibility.** This library is written in a way to not only be fully compatible with the current .travis.yml format, but also with the configuration data in the current Travis database and with the code interacting with the configuration data (for instance in travis-build).
* **Extensibility.** The configuration structure is easily extended.
* **Pluggable parser.** It is easy to write a new parser. This would be useful for instance for the Travis CI command line client, where one could imagine a parser for the small subset of the YAML format that is commonly in use. This would for instance allow to write a parser and serializer able to preserve comments and indentation when modifying the contents of the .travis.yml.

## What is missing?

* Full definition of current .travis.yml format
* Serialization

## Contributing

Good starting points for getting into the code are the [root](lib/travis/yaml/nodes/root.rb) node and the [language](lib/travis/yaml/nodes/language.rb) node.