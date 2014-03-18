describe Travis::Yaml::Nodes::OS do
  specify 'defaults to linux' do
    expect(Travis::Yaml.new.os).to be == ['linux']
  end

  specify 'defaults to osx for objective-c' do
    config = Travis::Yaml.parse(language: :objc)
    expect(config.os).to be == ['osx']
  end

  specify 'supports aliases' do
    config = Travis::Yaml.parse(os: [:ubuntu, :mac])
    expect(config.os).to be == ['linux', 'osx']
  end

  specify 'unsupported values' do
    config = Travis::Yaml.parse(os: :windows)
    expect(config.os).to be == ['linux']
    expect(config.os.first.warnings).to include('illegal value "windows", defaulting to "linux"')
  end
end
