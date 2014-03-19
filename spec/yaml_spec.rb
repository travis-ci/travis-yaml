describe Travis::Yaml do
  specify :parse! do
    expect(Travis::Yaml).to receive(:warn).
      with('.travis.yml: missing key "language", defaulting to "ruby"')
    Travis::Yaml.parse! ""
  end

  describe :new do
    specify 'with block' do
      config = Travis::Yaml.new { |c| c.language = 'php' }
      expect(config.language).to be == 'php'
      expect(config.nested_warnings).to be_empty
    end

    specify 'without block' do
      config = Travis::Yaml.new
      expect(config.language).to be == 'ruby'
      expect(config.nested_warnings).to include([[], 'missing key "language", defaulting to "ruby"'])
    end
  end

  specify :inspect do
    config = Travis::Yaml.parse(rvm: ['jruby', '2.0.0'], language: :ruby)
    expect(config.inspect).to be == '#<Travis::Yaml:{"ruby"=>["jruby", "2.0.0"], "language"=>"ruby", "os"=>"linux"}>'
  end
end