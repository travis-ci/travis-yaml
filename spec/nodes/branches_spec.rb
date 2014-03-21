describe Travis::Yaml::Nodes::Branches do
  context 'from Ruby' do
    specify 'with string' do
      config = Travis::Yaml.parse(branches: 'foo')
      expect(config.branches).to be == { 'only' => ['foo'] }
    end

    specify 'with regexp' do
      config = Travis::Yaml.parse(branches: /foo/)
      expect(config.branches).to be == { 'only' => [/foo/] }
    end

    specify 'with array' do
      config = Travis::Yaml.parse(branches: [/foo/, 'bar'])
      expect(config.branches).to be == { 'only' => [/foo/, 'bar'] }
    end

    specify 'with hash' do
      config = Travis::Yaml.parse(branches: { except: /foo/ })
      expect(config.branches).to be == { 'except' => [/foo/] }
    end
  end

  context 'from YAML' do
    specify 'with string' do
      config = Travis::Yaml.parse('branches: foo')
      expect(config.branches).to be == { 'only' => ['foo'] }
    end

    specify 'with regexp' do
      config = Travis::Yaml.parse('branches: /foo/')
      expect(config.branches).to be == { 'only' => [/foo/] }
    end

    specify 'with array' do
      config = Travis::Yaml.parse('branches: [/foo/, bar]')
      expect(config.branches).to be == { 'only' => [/foo/, 'bar'] }
    end

    specify 'with hash' do
      config = Travis::Yaml.parse('branches: { except: /foo/ }')
      expect(config.branches).to be == { 'except' => [/foo/] }
    end
  end
end
