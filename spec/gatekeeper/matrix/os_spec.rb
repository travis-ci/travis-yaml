describe Travis::Yaml::Patch, 'matrix env' do
  def matrix(yaml = '')
    Travis::Yaml::Matrix.new(Travis::Yaml.parse(yaml) { |config| described_class.apply(config) })
  end

  it 'defaults to linux' do
    confs = matrix
    expect(confs[0]['os']).to eq 'linux'
  end

  it 'given as a string' do
    confs = matrix %(
      os: osx
    )
    expect(confs[0]['os']).to eq 'osx'
  end

  it 'given as an array' do
    confs = matrix %(
      os:
        - linux
        - osx
    )
    expect(confs[0]['os']).to eq 'linux'
    expect(confs[1]['os']).to eq 'osx'
  end

  it 'maps language: objective-c to os: osx' do
    confs = matrix %(
      language: objective-c
    )
    expect(confs[0]['os']).to eq 'osx'
  end
end
