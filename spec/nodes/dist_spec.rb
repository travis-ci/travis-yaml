describe Travis::Yaml::Nodes::Dist do
  it 'adds warnings about feature' do
    expect(Travis::Yaml.parse(language: 'ruby', dist: 'precise').warnings).
      to include('your repository must be feature flagged for the "dist" setting to be used')
  end

  specify 'set dist value' do
    config = Travis::Yaml.parse(dist: 'trusty')
    expect(config.dist).to eq 'trusty'
  end
end
