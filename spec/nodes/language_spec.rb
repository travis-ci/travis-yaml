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
  end
end