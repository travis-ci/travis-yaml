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

    specify 'with conditions' do
      config = Travis::Yaml.parse(deploy: { provider: :heroku, on: :production })
      expect(config.deploy.first.on.branch).to be == "production"
    end

    specify 'with multiple conditions' do
      config = Travis::Yaml.parse(deploy: { provider: :heroku, on: { rvm: "2.0.0", repo: 'foo/bar', tags: true } })
      expect(config.deploy.first.on).to be == { 'ruby' => '2.0.0', 'repo' => 'foo/bar', 'tags' => true }
    end

    specify 'with branch specific settings' do
      config = Travis::Yaml.parse(deploy: { provider: :heroku, foo: { master: :bar, staging: :baz } })
      expect(config.deploy.first['foo'])    .to be == { 'master' => 'bar', 'staging' => 'baz' }
      expect(config.deploy.nested_warnings) .to be_empty
    end

    specify 'branches in settings that are not in the condition' do
      config = Travis::Yaml.parse(deploy: { provider: :heroku, foo: { master: :bar, staging: :baz }, on: :master })
      expect(config.deploy.first['foo'])    .to be == { 'master' => 'bar' }
      expect(config.deploy.nested_warnings) .to include([['foo'], 'branch "staging" not permitted by deploy condition, dropping'])
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