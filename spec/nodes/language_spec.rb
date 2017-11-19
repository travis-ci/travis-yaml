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

    specify 'supports dart aliases' do
      aliases = ['dartlang']
      assert_all_aliases(aliases, 'dart')
    end

    specify 'supports java aliases' do
      aliases = ['jvm']
      assert_all_aliases(aliases, 'java')
    end

    specify 'supports node_js aliases' do
      aliases = ['javascript', 'node', 'nodejs', 'node.js']
      assert_all_aliases(aliases, 'node_js')
    end

    specify 'supports go aliases' do
      aliases = ['golang']
      assert_all_aliases(aliases, 'go')
    end

    specify 'supports objective-c aliases' do
      aliases = ['objective_c', 'obj_c', 'obj-c', 'objc']
      assert_all_aliases(aliases, 'objective-c')
    end

    specify 'supports cpp aliases' do
      aliases = ['c++']
      assert_all_aliases(aliases, 'cpp')
    end

    specify 'supports generic aliases' do
      aliases = ['bash', 'sh', 'shell']
      assert_all_aliases(aliases, 'generic')
    end
  end

  def assert_all_aliases(aliases, language)
    aliases.each do |a|
      config = Travis::Yaml.parse("language: #{a}")
      expect(config.language).to be == language
    end
  end
end
