describe Travis::Yaml::Nodes::Language do
  context 'from ruby' do
    specify 'default language' do
      config = Travis::Yaml.parse({})
      expect(config.language).to be == 'ruby'
      expect(config.nested_warnings).to include([[], "missing key \"language\", defaulting to \"ruby\""])
    end

    specify 'set to valid language' do
      expect(Travis::Yaml.parse(language: 'php').language).to be == 'php'
    end

    specify 'ignores case' do
      expect(Travis::Yaml.parse(language: 'PHP').language).to be == 'php'
    end

    specify 'set to an invalid language' do
      config = Travis::Yaml.parse(language: 'sql')
      expect(config.language).to be == 'ruby'
      expect(config.nested_warnings).to include([["language"], "illegal value \"sql\", defaulting to \"ruby\""])
    end

    specify 'supports aliases' do
      config = Travis::Yaml.parse(language: 'javascript')
      expect(config.language).to be == 'node_js'
    end

    specify 'supports singe element arrays' do
      config = Travis::Yaml.parse(language: ['javascript'])
      expect(config.language)           .to be == 'node_js'
      expect(config.language.warnings)  .to be_empty
    end

    specify 'complains about multi element arrays' do
      config = Travis::Yaml.parse(language: ['javascript', 'ruby'])
      expect(config.language)           .to be == 'node_js'
      expect(config.language.warnings)  .to include('does not support multiple values, dropping "ruby"')
    end
  end

  context 'from yaml' do
    specify 'default language' do
      config = Travis::Yaml.parse('')
      expect(config.language).to be == 'ruby'
      expect(config.nested_warnings).to include([[], "missing key \"language\", defaulting to \"ruby\""])
    end

    specify 'set to valid language' do
      expect(Travis::Yaml.parse('language: php').language).to be == 'php'
    end

    specify 'ignores case' do
      expect(Travis::Yaml.parse('language: PHP').language).to be == 'php'
    end

    specify 'set to an invalid language' do
      config = Travis::Yaml.parse('language: sql')
      expect(config.language).to be == 'ruby'
      expect(config.nested_warnings).to include([["language"], "illegal value \"sql\", defaulting to \"ruby\""])
    end

    specify 'supports aliases' do
      config = Travis::Yaml.parse('language: javascript')
      expect(config.language).to be == 'node_js'
    end

    specify 'supports singe element arrays' do
      config = Travis::Yaml.parse("language: [javascript]")
      expect(config.language)           .to be == 'node_js'
      expect(config.language.warnings)  .to be_empty
    end

    specify 'complains about multi element arrays' do
      config = Travis::Yaml.parse("language: [javascript, ruby]")
      expect(config.language)           .to be == 'node_js'
      expect(config.language.warnings)  .to include('does not support multiple values, dropping "ruby"')
    end

    specify 'supports all un-aliased languages' do
      languages = Travis::Yaml::Nodes::Language.valid_values
      languages.each do |lang|
        config = Travis::Yaml.parse("language: #{lang}")
        expect(config.language).to be == lang
      end
    end
  end
end
