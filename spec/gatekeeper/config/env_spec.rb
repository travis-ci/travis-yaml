describe Travis::Yaml::Patch, 'config env' do
  def parse(yaml)
    Travis::Yaml.parse(yaml) { |config| described_class.apply(config) }
  end

  def env_from(yaml)
    parse(yaml)['env']
  end

  it 'keeps the given env if it is an array' do
    env = env_from %(
      env:
        - FOO=foo
        - BAR=bar
    )
    expect(env).to eq(
      'matrix' => [
        'FOO=foo',
        'BAR=bar'
      ]
    )
  end

  # TODO i think this should be supported
  it 'normalizes an env vars hash to an array of strings' do
    env = env_from %(
      env:
        FOO: foo
        BAR: bar
    )
    expect(env).to eq(
      'matrix' => [
        'FOO=foo BAR=bar'
      ]
    )
  end

  it 'keeps env vars global and matrix arrays' do
    env = env_from %(
      env:
        global:
          - FOO=foo
          - BAR=bar
        matrix:
          - BAZ=baz
          - BUZ=buz
    )
    expect(env).to eq(
      'global' => [
        'FOO=foo',
        'BAR=bar'
      ],
      'matrix' => [
        'BAZ=baz',
        'BUZ=buz'
      ]
    )
  end

  # TODO i think this should be supported
  it 'normalizes env vars global and matrix which are hashes to an array of strings' do
    env = env_from %(
      env:
        global:
          FOO: foo
          BAR: bar
        matrix:
          BAZ: baz
          BUZ: buz
    )
    expect(env).to eq(
      'global' => [
        'FOO=foo BAR=bar'
      ],
      'matrix' => [
        'BAZ=baz BUZ=buz'
      ]
    )
  end

  it 'works fine if matrix part of env is undefined' do
    env = env_from %(
      env:
        global: FOO=foo
    )
    expect(env).to eq(
      'global' => [
        'FOO=foo'
      ]
    )
  end

  it 'works fine if global part of env is undefined' do
    env = env_from %(
      env:
        matrix: FOO=foo
    )
    expect(env).to eq(
      'matrix' => [
        'FOO=foo'
      ]
    )
  end

  # TODO i think this can be removed, it's just invalid
  # Comment from Gatekeeper: Seems odd. What's the usecase? Broken yaml?
  xit 'keeps matrix and global config as arrays, not hashes' do
    env = env_from %(
      env:
        global: FOO=foo
        matrix:
          -
            - BAR=bar
            - BAZ=baz
          - BUZ=buz
    )
    expect(env).to eq(
      'global' => [
        'FOO=foo'
      ],
      'matrix' => [
        ['BAR=bar', 'BAZ=baz'],
        'BUZ=buz'
      ]
    )
  end

  # TODO i think this can be removed, it's just invalid
  # Comment from Gatekeeper: Seems super odd. Do people actually pass such stuff?
  xit 'keeps wild nested array/hashes structure' do
    env = env_from %(
      env:
        -
          -
            foo: bar
          - FOO=foo
        -
          -
            BAR: bar
            BAZ: baz
    )
    expect(env).to eq(
      'matrix' => [
        [{ 'foo' => 'bar' }, 'FOO=foo'],
        ['BAR=bar BAZ=baz']
      ]
    )
  end
end
