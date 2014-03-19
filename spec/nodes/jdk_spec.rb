describe Travis::Yaml::Nodes::JDK do
  context 'from ruby' do
    specify 'java' do
      config = Travis::Yaml.parse(language: :java, jdk: 'default')
      expect(config.jdk).to be == ['default']
    end

    specify 'scala' do
      config = Travis::Yaml.parse(language: :scala, jdk: 'default')
      expect(config.jdk).to be == ['default']
    end

    specify 'clojure' do
      config = Travis::Yaml.parse(language: :clojure, jdk: 'default')
      expect(config.jdk).to be == ['default']
    end

    specify 'groovy' do
      config = Travis::Yaml.parse(language: :groovy, jdk: 'default')
      expect(config.jdk).to be == ['default']
    end

    specify 'c' do
      config = Travis::Yaml.parse(language: :c, jdk: 'default')
      expect(config.jdk).to be_nil
      expect(config.warnings).to include('specified "jdk", but setting is not relevant for "c"')
    end

    specify 'ruby without jruby' do
      config = Travis::Yaml.parse(language: :ruby, jdk: 'default')
      expect(config.jdk).to be_nil
      expect(config.warnings).to include('dropping "jdk" section: specified "jdk", but "ruby" does not include "jruby"')
    end

    specify 'ruby with jruby' do
      config = Travis::Yaml.parse(language: :ruby, jdk: 'default', ruby: ['2.0.0', 'jruby'])
      expect(config.jdk).to be == ['default']
      expect(config.warnings).to be_empty
    end
  end
end