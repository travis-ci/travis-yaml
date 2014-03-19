describe Travis::Yaml::Nodes::BundlerArgs do
  context 'from Ruby' do
    specify 'can only be set for Ruby' do
      expect(Travis::Yaml.parse(language: 'ruby', bundler_args: '--local').warnings).to be_empty
      expect(Travis::Yaml.parse(language: 'php',  bundler_args: '--local').warnings).to \
        include('specified "bundler_args", but setting is not relevant for "php"')
    end
  end
end
