describe Travis::Yaml::Patch, 'matrix group' do
  def matrix(yaml = '')
    Travis::Yaml::Matrix.new(Travis::Yaml.parse(yaml) { |config| described_class.apply(config) })
  end

  it 'defaults to stable' do
    confs = matrix
    expect(confs[0]['group']).to eq 'stable'
  end

  it 'given as a string' do
    confs = matrix %(
      group: test
    )
    expect(confs[0]['group']).to eq 'test'
  end
end
