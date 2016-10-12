describe Travis::Yaml::Patch, 'config dist' do
  def parse(yaml = '', options = {}) # TODO how to pass in feature flags?
    Travis::Yaml.parse(yaml) { |config| described_class.apply(config) }
  end

  it 'sets dist to the default' do
    config = parse
    expect(config['dist']).to eq 'precise'
  end

  it 'with a dist' do
    config = parse %(
      dist: precise
    )
    expect(config['dist']).to eq 'precise' # TODO check: this used to accept arbitrary strings
  end

  it 'sets dist for an override language' do
    config = parse %(
      language: objective-c
    )
    expect(config['dist']).to eq 'osx'
  end

  it 'sets dist for an override os' do
    config = parse %(
      os: osx
    )
    expect(config['dist']).to eq 'osx'
  end

  it 'sets dist for an override language and os' do
    config = parse %(
      language: objective-c
      os: osx
    )
    expect(config['dist']).to eq 'osx'
  end

  it 'sets dist for an override language with multi_os enabled' do
    config = parse %(language: objective-c), multi_os: true
    expect(config['dist']).to eq 'osx'
  end

  it 'sets dist for a non-override language with multi_os enabled' do
    config = parse %(language: goober), multi_os: true
    expect(config['dist']).to eq 'precise'
  end

  it 'with dist given as an array with a known first entry' do
    config = parse %(language: goober), multi_os: true
    expect(config['dist']).to eq 'precise'
  end

  it 'with dist given as an array with an unknown first entry' do
    config = parse %(
      os:
        - freebsd
        - osx
    )
    expect(config['dist']).to eq 'precise'
  end

  it 'sets the dist to trusty with docker in services' do
    config = parse %(
      services:
        - docker
    )
    expect(config['dist']).to eq 'trusty'
  end
end
