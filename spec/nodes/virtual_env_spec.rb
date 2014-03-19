describe Travis::Yaml::Nodes::VirtualEnv do
  context 'from Ruby' do
    specify 'can only be set for python' do
      expect(Travis::Yaml.parse(language: 'python', virtualenv: { system_site_packages: true }).warnings).to be == []
      expect(Travis::Yaml.parse(language: 'php',    virtualenv: { system_site_packages: true }).warnings).to \
        include('specified "virtualenv", but setting is not relevant for "php"')
    end
  end
end
