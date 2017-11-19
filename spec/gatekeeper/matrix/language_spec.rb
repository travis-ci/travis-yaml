describe Travis::Yaml::Patch, 'matrix language' do
  def matrix(yaml = '')
    Travis::Yaml::Matrix.new(Travis::Yaml.parse(yaml) { |config| described_class.apply(config) })
  end

  it 'defaults to ruby' do
    confs = matrix
    expect(confs[0]['language']).to eq 'ruby'
  end

  it 'given as a string' do
    confs = matrix %(
      language: clojure
    )
    expect(confs[0]['language']).to eq 'clojure'
  end

  it 'downcases the language' do
    confs = matrix %(
      language: PYTHON
    )
    expect(confs[0]['language']).to eq 'python'
  end
end
