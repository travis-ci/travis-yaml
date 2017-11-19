describe Travis::Yaml::Patch, 'matrix dist' do
  def matrix(yaml = '')
    Travis::Yaml::Matrix.new(Travis::Yaml.parse(yaml) { |config| described_class.apply(config) })
  end

  it 'defaults to precise' do
    confs = matrix
    expect(confs[0]['dist']).to eq 'precise'
  end

  it 'given as a string' do
    confs = matrix %(
      dist: trusty
    )
    expect(confs[0]['dist']).to eq 'trusty'
  end

  describe 'overrides' do
    # Comment from Gatekeeper:
    # Interestingly this fails, it seems it has language: 'ruby' at that point
    # and returns early
    it 'given os: osx it sets dist: osx' do
      confs = matrix %(
        os: osx
      )
      expect(confs[0]['dist']).to eq 'osx'
    end

    describe 'given language: objective-c' do
      # TODO check: this is kinda inconsistent with #22 'given os: osx it sets
      # dist: osx' as the os is also set by the language, so this depends on
      # the order of things executed/normalized.
      # I think we should remove one of these (#22 or this one)
      xit 'it does not override the given dist' do
        confs = matrix %(
          language: objective-c
          dist: trusty
        )
        expect(confs[0]['dist']).to eq 'trusty'
      end

      it 'it defaults dist: osx' do
        confs = matrix %(
          language: objective-c
        )
        expect(confs[0]['dist']).to eq 'osx'
      end
    end

    describe 'given os: osx and language: objective-c' do
      # TODO check: this is kinda inconsistent with #22 'given os: osx it sets
      # dist: osx' as the os is also set by the language, so this depends on
      # the order of things executed/normalized.
      # I think we should remove one of these (#22 or this one)
      xit 'it does not override the given dist' do
        confs = matrix %(
          os: osx
          language: objective-c
          dist: trusty
        )
        expect(confs[0]['dist']).to eq 'trusty'
      end

      it 'it defaults dist: osx' do
        confs = matrix %(
          os: osx
          language: objective-c
        )
        expect(confs[0]['dist']).to eq 'osx'
      end
    end

    # Comment from Gatekeeper:
    # This seems wrong, doesn't it?
    it 'given os: [osx, linux] it sets dist: osx' do
      confs = matrix %(
        os:
          - linux
          - osx
      )
      expect(confs[0]['dist']).to eq 'precise'
      expect(confs[1]['dist']).to eq 'precise'
    end

    it 'given services: docker it sets dist: trusty' do
      confs = matrix %(
        services:
          - docker
      )
      expect(confs[0]['dist']).to eq 'trusty'
    end
  end
end
