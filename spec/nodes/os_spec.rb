describe Travis::Yaml::Nodes::OS do
  specify 'defaults to linux' do
    expect(Travis::Yaml.new.os).to be == ['linux']
  end

  specify 'defaults to osx for objective-c' do
    config = Travis::Yaml.parse(language: :objc)
    expect(config.os).to be == ['osx']
  end

  specify 'supports aliases' do
    config = Travis::Yaml.parse(os: [:ubuntu, :mac], language: 'ruby')
    expect(config.os).to be == ['linux', 'osx']
  end

  specify 'unsupported values' do
    config = Travis::Yaml.parse(os: :windows)
    expect(config.os).to be == ['linux']
    expect(config.os.first.warnings).to include('illegal value "windows", defaulting to "linux"')
  end

  specify 'checks if the os suppors the language' do
    config = Travis::Yaml.parse(os: :linux, language: :objc)
    expect(config.os).to be == ['osx']
    expect(config.os.warnings).to include('dropping "linux", does not support "objective-c"')
    expect(config.os.warnings).to include('no suitable operating system given for "objective-c", using "osx"')
  end

  specify 'complains about jdk on osx' do
    config = Travis::Yaml.parse(os: :osx, language: :java, jdk: :default)
    expect(config.os)       .to be == ['osx']
    expect(config.language) .to be == 'java'
    expect(config.jdk)      .to be_nil
    expect(config.warnings).to include('dropping "jdk" section: currently not supported on "osx"')
  end

  specify 'does not complain about the default os' do
    config = Travis::Yaml.parse(language: 'objective-c')
    expect(config.warnings).to be_empty
  end
end
