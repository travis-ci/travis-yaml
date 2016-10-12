describe Travis::Yaml::Patch, 'config group' do
  def parse(yaml = '', options = {}) # TODO how to pass in feature flags?
    Travis::Yaml.parse(yaml) { |config| described_class.apply(config) }
  end

  it 'sets group to the default' do
    config = parse
    expect(config['group']).to eq 'stable'
  end

  it 'keeps a given group' do
    config = parse %(
      group: foo
    )
    expect(config['group']).to eq 'foo'
  end
end
