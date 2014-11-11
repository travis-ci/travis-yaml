describe Travis::Yaml::Nodes::Group do
  specify 'has no warnings' do
    expect(Travis::Yaml.parse(language: 'ruby', group: 'dev').warnings).to be_empty
  end

  specify 'set group value' do
    config = Travis::Yaml.parse(group: 'update')
    expect(config.group).to eq 'update'
  end
end
