describe Travis::Yaml::Nodes::Addons do
  context 'from Ruby' do
    def addons(input)
      Travis::Yaml.parse!(language: 'ruby', addons: input).addons
    end

    context 'code_climate' do
      example { expect(addons(code_climate: true).code_climate).to be == {} }
      example { expect(addons(code_climate: { repo_token: "foo" }).code_climate.repo_token).to be == "foo" }
    end

    context 'coverity_scan' do
      example do
        config = addons(coverity_scan: { project: { name: :foo } })
        expect(config.coverity_scan.project.name).to be == "foo"
      end
    end

    context 'firefox' do
      example { expect(addons(firefox: '15').firefox).to be == '15' }
    end

    context 'hosts' do
      example { expect(addons(hosts: 'foo.dev').hosts).to be == ['foo.dev'] }
      example { expect(addons(hosts: ['foo.dev', 'bar.dev']).hosts).to be == ['foo.dev', 'bar.dev'] }
    end

    context 'postgresql' do
      example { expect(addons(postgresql: '9.1').postgresql).to be == '9.1' }
    end

    context 'sauce_connect' do
      example { expect(addons(sauce_connect: true).sauce_connect).to be == {} }
      example { expect(addons(sauce_connect: { username: "foo" }).sauce_connect.username).to be == "foo" }
    end

    context 'ssh_known_hosts' do
      example { expect(addons(ssh_known_hosts: 'git.example.org').ssh_known_hosts).to be == ['git.example.org'] }
      example { expect(addons(ssh_known_hosts: ['git.example.org', 'git.example.com']).ssh_known_hosts).to be == ['git.example.org', 'git.example.com'] }
    end
  end
end
