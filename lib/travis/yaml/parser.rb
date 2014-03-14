module Travis::Yaml
  module Parser
    require 'travis/yaml/parser/dummy'
    require 'travis/yaml/parser/psych'
    require 'travis/yaml/parser/ruby'

    extend self, Enumerable

    def parses?(value)
      !!parser_for(value)
    end

    def parse(value)
      raise ArgumentError, "cannot parse %p" % value unless parser = parser_for(value)
      parser.parse(value)
    end

    def parser_for(value)
      detect { |p| p.parses? value if p.respond_to? :parses? }
    end

    def each(&block)
      parsers.each(&block)
    end

    def parsers
      constants.map { |name| const_get(name) }.
        select { |c| c.respond_to? :parse }
    end
  end
end