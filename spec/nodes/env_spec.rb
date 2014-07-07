describe Travis::Yaml::Nodes::Deploy do
  context 'from Ruby' do
    specify 'list of values' do
      config = Travis::Yaml.parse <<-YAML.gsub(/^ {8}/, '')
        ---
        language: ruby
        env:
        - "FOO=BAR"
        - "FOX=BAZ"
      YAML

      expect(config.nested_warnings).to be_empty
      expect(config.env.matrix.length).to be == 2
    end

    specify 'global with secure' do
      config = Travis::Yaml.parse <<-YAML.gsub(/^ {8}/, '')
        ---
        language: ruby
        env:
          global:
          - secure: "..."
          - secure: "..."
      YAML

      expect(config.nested_warnings).to be_empty
      expect(config.env.global.length).to be == 2
    end

    specify 'global and matrix' do
      config = Travis::Yaml.parse <<-YAML.gsub(/^ {8}/, '')
        ---
        language: ruby
        env:
          matrix:
          - "FOO=BAR"
          - "FOX=BAZ"
          global:
          - secure: "..."
          - secure: "..."
      YAML

      expect(config.nested_warnings).to be_empty
      expect(config.env.global.length).to be == 2
      expect(config.env.matrix.length).to be == 2
    end
  end
end
