describe Travis::Yaml::Parser::Dummy do
  example do
    config = Travis::Yaml.parse({})
    parsed = Travis::Yaml.parse(config)
    expect(parsed).to be == config
  end
end