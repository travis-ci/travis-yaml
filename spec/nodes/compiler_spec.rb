describe Travis::Yaml::Nodes::Compiler do
  context 'from Ruby' do
    specify 'can only be set for C++ and C' do
      expect(Travis::Yaml.parse(language: 'c',    compiler: 'gcc').warnings).to be_empty
      expect(Travis::Yaml.parse(language: 'c++',  compiler: 'gcc').warnings).to be_empty
      expect(Travis::Yaml.parse(language: 'ruby', compiler: 'gcc').warnings).to include('specified "compiler", but setting is not relevant for "ruby"')
    end

    specify 'allows an array' do
      config = Travis::Yaml.parse(language: 'c', compiler: ['gcc', 'clang'])
      expect(config.compiler).to be == ['gcc', 'clang']
    end
  end
end
