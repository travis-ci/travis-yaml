describe Travis::Yaml::Nodes::Stage do
  stages = [:before_install, :install, :before_script, :script, :after_result, :before_cache, 
            :after_script, :after_success, :after_failure, :before_deploy, :after_deploy]

  shared_examples "a stage" do
    specify 'with one entry' do
      config = Travis::Yaml.load(stage => 'rake')
      expect(config[stage]).to be == ['rake']
    end

    specify 'with multiple entries' do
      config = Travis::Yaml.load(stage => ['rake', 'echo 1'])
      expect(config[stage]).to be == ['rake', 'echo 1']
    end

    specify 'empty stage' do
      config = Travis::Yaml.load(stage => [])
      expect(config[stage]).to be_nil
      expect(config.warnings).to include("value for \"#{stage}\" section is empty, dropping")
    end

    specify 'no warnings if missing' do
      config = Travis::Yaml.load(language: "ruby")
      expect(config.warnings).to be_empty
    end
  end

  stages.each do |stage|
    describe stage do
      let(:stage) { stage }
      include_examples "a stage"
    end
  end
end
