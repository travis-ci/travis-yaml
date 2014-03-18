describe Travis::Yaml::Nodes::Ruby do
  context 'from ruby' do
    specify 'empty section' do
      config = Travis::Yaml.parse(ruby: [])
      expect(config.ruby).to be_nil
      expect(config.nested_warnings).to include([[], 'value for "ruby" section is empty, dropping'])
    end

    specify 'with a single value' do
      config = Travis::Yaml.parse(ruby: 'jruby')
      expect(config.ruby).to be == ['jruby']
    end

    specify 'with a list' do
      config = Travis::Yaml.parse(ruby: ['jruby', '2.0.0'])
      expect(config.ruby).to be == ['jruby', '2.0.0']
    end

    specify 'filters out invalid entries' do
      config = Travis::Yaml.parse(ruby: [:jruby, '2.0.0', nil, 1.0, { foo: :bar }])
      expect(config.ruby).to be == ['jruby', '2.0.0']
      expect(config.nested_warnings).to include([["ruby"], '"null" not supported, dropping ""'])
      expect(config.nested_warnings).to include([["ruby"], '"float" not supported, dropping "1.0"'])
      expect(config.nested_warnings).to include([["ruby"], 'unexpected mapping'])
    end

    specify 'called rvm' do
      config = Travis::Yaml.parse(rvm: ['jruby', '2.0.0'])
      expect(config.ruby)    .to be == ['jruby', '2.0.0']
      expect(config.rvm)     .to be == ['jruby', '2.0.0']
      expect(config["rvm"])  .to be == ['jruby', '2.0.0']
      expect(config[:ruby])  .to be == ['jruby', '2.0.0']
    end
  end

  context 'from yaml' do
    specify 'empty section' do
      config = Travis::Yaml.parse('ruby:')
      expect(config.ruby).to be_nil
      expect(config.nested_warnings).to include([[], 'value for "ruby" section is empty, dropping'])
    end

    specify 'with a single value' do
      config = Travis::Yaml.parse('ruby: jruby')
      expect(config.ruby).to be == ['jruby']
    end

    specify 'with a list' do
      config = Travis::Yaml.parse('ruby: [jruby, 2.0.0]')
      expect(config.ruby).to be == ['jruby', '2.0.0']
    end

    specify 'filters out invalid entries' do
      config = Travis::Yaml.parse('ruby: [jruby, 2.0, !null ~, !float 1.0, { foo: bar }]')
      expect(config.ruby).to be == ['jruby', '2.0']
      expect(config.nested_warnings).to include([["ruby"], '"null" not supported, dropping "~"'])
      expect(config.nested_warnings).to include([["ruby"], '"float" not supported, dropping "1.0"'])
      expect(config.nested_warnings).to include([["ruby"], 'unexpected mapping'])
    end

    specify 'called rvm' do
      config = Travis::Yaml.parse('rvm: [jruby, 2.0.0]')
      expect(config.ruby)    .to be == ['jruby', '2.0.0']
      expect(config.rvm)     .to be == ['jruby', '2.0.0']
      expect(config["rvm"])  .to be == ['jruby', '2.0.0']
      expect(config[:ruby])  .to be == ['jruby', '2.0.0']
    end
  end
end