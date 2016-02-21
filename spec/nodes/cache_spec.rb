describe Travis::Yaml::Nodes::Cache do
  context 'from Ruby' do
    specify 'with true' do
      config = Travis::Yaml.parse(cache: true)
      expect(config.cache).to be == { 'apt' => true, 'bundler' => true, 'cocoapods' => true, 'pip' => true, 'ccache' => true }
    end

    specify 'with false' do
      config = Travis::Yaml.parse(cache: false)
      expect(config.cache).to be == { 'apt' => false, 'bundler' => false, 'cocoapods' => false, 'pip' => false, 'ccache' => false }
    end

    specify 'with string' do
      config = Travis::Yaml.parse(cache: 'apt')
      expect(config.cache).to be == { 'apt' => true }
    end

    specify 'with array' do
      config = Travis::Yaml.parse(cache: ['apt', 'bundler'])
      expect(config.cache).to be == { 'apt' => true, 'bundler' => true }
    end

    specify 'with hash' do
      config = Travis::Yaml.parse(cache: { bundler: true, directories: ['a', 'b'] })
      expect(config.cache).to be == { 'bundler' => true, 'directories' => ['a', 'b'] }
    end
  end

  context 'from YAML' do
    specify 'with true' do
      config = Travis::Yaml.parse('cache: on')
      expect(config.cache).to be == { 'apt' => true, 'bundler' => true, 'cocoapods' => true, 'pip' => true, 'ccache' => true }
    end

    specify 'with false' do
      config = Travis::Yaml.parse('cache: off')
      expect(config.cache).to be == { 'apt' => false, 'bundler' => false, 'cocoapods' => false, 'pip' => false, 'ccache' => false }
    end

    specify 'with string' do
      config = Travis::Yaml.parse('cache: apt')
      expect(config.cache).to be == { 'apt' => true }
    end

    specify 'with array' do
      config = Travis::Yaml.parse('cache: [apt, bundler]')
      expect(config.cache).to be == { 'apt' => true, 'bundler' => true }
    end

    specify 'with hash' do
      config = Travis::Yaml.parse('cache: { bundler: true, directories: [a, b] }')
      expect(config.cache).to be == { 'bundler' => true, 'directories' => ['a', 'b'] }
    end
  end
end
