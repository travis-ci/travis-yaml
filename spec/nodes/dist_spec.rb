describe Travis::Yaml::Nodes::Dist do
  specify 'has no warnings' do
    expect(Travis::Yaml.parse(language: 'ruby', dist: 'precise').warnings).to be_empty
  end

  specify 'set dist value' do
    config = Travis::Yaml.parse(dist: 'trusty')
    expect(config.dist).to eq 'trusty'
  end
end
