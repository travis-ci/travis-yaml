describe Travis::Yaml::SecureString do
  context 'encrypted value with secure mapping' do
    subject(:config) { Travis::Yaml.load 'env: { secure: "foo" }' }
    it { should     be_encrypted }
    it { should_not be_decrypted }

    context 'its value' do
      subject(:value) { config.env.matrix.first.value  }
      it { should     be_a(Travis::Yaml::SecureString) }
      it { should     be_encrypted                     }
      it { should_not be_decrypted                     }
    end

    context 'after decryption' do
      before { config.decrypt { |v| v.upcase } }
      it { should be_encrypted }
      it { should be_decrypted }

      context 'its value' do
        subject(:value) { config.env.matrix.first.value }
        it { should be_encrypted }
        it { should be_decrypted }

        specify 'correct encrypted and decrypted value' do
          expect(value.encrypted_string).to be == 'foo'
          expect(value.decrypted_string).to be == 'FOO'
        end
      end
    end
  end

  context 'encrypted value with secure tag' do
    subject(:config) { Travis::Yaml.load 'env: !secure "foo"' }
    it { should     be_encrypted }
    it { should_not be_decrypted }

    context 'its value' do
      subject(:value) { config.env.matrix.first.value  }
      it { should     be_a(Travis::Yaml::SecureString) }
      it { should     be_encrypted                     }
      it { should_not be_decrypted                     }
    end
  end

  context 'encrypted value with encrypted tag' do
    subject(:config) { Travis::Yaml.load 'env: !encrypted "foo"' }
    it { should     be_encrypted }
    it { should_not be_decrypted }

    context 'its value' do
      subject(:value) { config.env.matrix.first.value  }
      it { should     be_a(Travis::Yaml::SecureString) }
      it { should     be_encrypted                     }
      it { should_not be_decrypted                     }
    end
  end

  context 'encrypted value with decrypted tag' do
    subject(:config) { Travis::Yaml.load 'env: !decrypted "foo"' }
    it { should_not be_encrypted }
    it { should     be_decrypted }

    context 'its value' do
      subject(:value) { config.env.matrix.first.value  }
      it { should     be_a(Travis::Yaml::SecureString) }
      it { should_not be_encrypted                     }
      it { should     be_decrypted                     }
    end

    context 'after encryption' do
      before { config.encrypt { |v| v.upcase } }
      it { should be_encrypted }
      it { should be_decrypted }

      context 'its value' do
        subject(:value) { config.env.matrix.first.value }
        it { should be_encrypted }
        it { should be_decrypted }

        specify 'correct encrypted and decrypted value' do
          expect(value.encrypted_string).to be == 'FOO'
          expect(value.decrypted_string).to be == 'foo'
        end
      end
    end
  end

  context 'encrypted value in secure mapping with decrypted tag' do
    subject(:config) { Travis::Yaml.load 'env: { secure: !decrypted "foo" }' }
    it { should_not be_encrypted }
    it { should     be_decrypted }

    context 'its value' do
      subject(:value) { config.env.matrix.first.value  }
      it { should     be_a(Travis::Yaml::SecureString) }
      it { should_not be_encrypted                     }
      it { should     be_decrypted                     }
    end
  end

  specify 'in an unexpected place' do
    config = Travis::Yaml.load('language: { secure: ruby }')
    expect(config.warnings).to include('dropping "language" section: "secure" not supported, dropping "ruby"')
  end

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