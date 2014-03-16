describe Travis::Yaml::Nodes::Deploy do
  describe 'from ruby' do
    specify 'empty section' do
      config = Travis::Yaml.parse(deploy: {})
      expect(config.deploy).to be_nil
      expect(config.nested_warnings).to include([[], 'value for "deploy" section is empty, dropping'])
    end

    specify 'without provider' do
      config = Travis::Yaml.parse(deploy: { foo: :bar })
      expect(config.deploy).to be_nil
      expect(config.nested_warnings).to include([['deploy'], 'missing key "provider"'])
      expect(config.nested_warnings).to include([[], 'value for "deploy" section is empty, dropping'])
    end

    specify 'with a string' do
      config = Travis::Yaml.parse(deploy: 'heroku')
      expect(config.deploy)                 .to be == [{"provider" => "heroku"}]
      expect(config.deploy.nested_warnings) .to be_empty
    end

    specify 'with one provider' do
      config = Travis::Yaml.parse(deploy: { provider: :heroku })
      expect(config.deploy)                 .to be == [{"provider" => "heroku"}]
      expect(config.deploy.nested_warnings) .to be_empty
    end

    specify 'with multiple providers' do
      config = Travis::Yaml.parse(deploy: [{ provider: :heroku }, { provider: :heroku }])
      expect(config.deploy)                 .to be == [{"provider" => "heroku"}, {"provider" => "heroku"}]
      expect(config.deploy.nested_warnings) .to be_empty
    end

    specify 'stores arbitrary data' do
      config = Travis::Yaml.parse(deploy: { provider: :heroku, foo: :bar })
      expect(config.deploy.first['foo'])    .to be == "bar"
      expect(config.deploy.nested_warnings) .to be_empty
    end
  end

  describe 'from yaml' do
    specify 'empty section' do
      config = Travis::Yaml.parse('deploy: ')
      expect(config.deploy).to be_nil
      expect(config.nested_warnings).to include([[], 'value for "deploy" section is empty, dropping'])
    end

    specify 'without provider' do
      config = Travis::Yaml.parse('deploy: { foo: bar }')
      expect(config.deploy).to be_nil
      expect(config.nested_warnings).to include([['deploy'], 'missing key "provider"'])
      expect(config.nested_warnings).to include([[], 'value for "deploy" section is empty, dropping'])
    end

    specify 'with one provider' do
      config = Travis::Yaml.parse('deploy: { provider: heroku }')
      expect(config.deploy)                 .to be == [{"provider" => "heroku"}]
      expect(config.deploy.nested_warnings) .to be_empty
    end

    specify 'with multiple providers' do
      config = Travis::Yaml.parse('deploy: [{ provider: heroku }, { provider: heroku }]')
      expect(config.deploy)                 .to be == [{"provider" => "heroku"}, {"provider" => "heroku"}]
      expect(config.deploy.nested_warnings) .to be_empty
    end

    specify 'stores arbitrary data' do
      config = Travis::Yaml.parse('deploy: { provider: heroku, foo: bar }')
      expect(config.deploy.first['foo'])    .to be == "bar"
      expect(config.deploy.nested_warnings) .to be_empty
    end
  end
end