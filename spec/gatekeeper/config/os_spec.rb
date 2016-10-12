describe Travis::Yaml::Patch, 'config os' do
  def parse(yaml = '')
    Travis::Yaml.parse(yaml) { |config| described_class.apply(config) }
  end

  it 'defaults to linux' do
    config = parse
    expect(config['os']).to eq 'linux'
  end

  it 'sets the os value to osx for objective-c builds' do
    config = parse %(
      language: objective-c
    )
    expect(config['os']).to eq 'osx'
  end

  it 'sets the os value to linux for other builds' do
    config = parse %(
      language: ruby
    )
    expect(config['os']).to eq 'linux'
  end
end
