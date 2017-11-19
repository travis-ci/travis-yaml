describe Travis::Yaml::Patch, 'config deploy' do
  def parse(yaml)
    Travis::Yaml.parse(yaml) { |config| described_class.apply(config) }
  end

  it 'normalizes deploy config' do
    config = parse %(
      deploy:
        provider: heroku
    )
    expect(config['deploy']).to be nil
    # expect(config['addons']['deploy']).to eq 'provider' => 'heroku' # TODO this used to be true: confirm this is ok
    expect(config['addons']['deploy']).to eq ['provider' => 'heroku']
  end

  it 'drops addons if non-hash and deploy is present' do
    config = parse %(
      addons:
        - something
      deploy:
        provider: heroku
    )
    expect(config['deploy']).to be nil
    expect(config['addons']['deploy']).to eq ['provider' => 'heroku']
  end
end
