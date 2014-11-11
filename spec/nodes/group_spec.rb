describe Travis::Yaml::Nodes::Group do
  it 'adds warnings about feature' do
    expect(Travis::Yaml.parse(group: 'dev').warnings).
      to include('your repository must be feature flagged for the "group" setting to be used')
  end

  specify 'set group value' do
    config = Travis::Yaml.parse(group: 'update')
    expect(config.group).to eq 'update'
  end
end
