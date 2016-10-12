describe Travis::Yaml::Patch, 'config language' do
  def parse(yaml = '')
    Travis::Yaml.parse(yaml) { |config| described_class.apply(config) }
  end

  it 'defaults to ruby' do
    config = parse
    expect(config['language']).to eq 'ruby'
  end

  it 'downcases language' do
    config = parse %(
      language: PYTHON
    )
    expect(config['language']).to eq 'python'
  end
end
