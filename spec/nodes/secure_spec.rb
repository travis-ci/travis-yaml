describe Travis::Yaml::SecureString do
  specify 'secure cannot be a key in an open mapping' do
    config = Travis::Yaml.load <<-YAML.gsub(/^      /, "")
      language: python
      python:
        - 2.7

      deploy:
        provider: heroku
        strategy: git
        api_key:
        secure:
          secure: |-
             SECRET HERE
    YAML

    deploy = config.deploy.first
    expect(deploy[:secure]).to be_nil
    expect(deploy.warnings).to include('unexpected key "secure", dropping')
  end

  specify 'secure cannot be nested' do
    config = Travis::Yaml.load <<-YAML.gsub(/^      /, "")
      language: python
      python:
        - 2.7

      deploy:
        provider: heroku
        strategy: git
        api_key:
          secure:
            secure: |-
              SECRET HERE
    YAML

    deploy = config.deploy.first
    expect(deploy[:api_key]).to be_nil
    expect(deploy.warnings).to include('dropping "api_key" section: secret value needs to be a string')
  end
end