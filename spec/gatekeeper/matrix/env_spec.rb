describe Travis::Yaml::Patch, 'matrix env' do
  def matrix(yaml = '')
    Travis::Yaml::Matrix.new(Travis::Yaml.parse(yaml) { |config| described_class.apply(config) })
  end

  it 'given as an array' do
    confs = matrix %(
      env:
        - FOO=foo
        - BAR=bar
    )
    expect(confs.size).to eq 2
    expect(confs.map { |c| c['env']['global'] }).to eq %w(FOO=foo BAR=bar)
  end

  # TODO this is a consequence of config/env_spec.rb:25 'normalizes an env vars
  # hash to an array of strings' which i think should be supported and fixed
  xit 'given as a hash' do
    confs = matrix %(
      env:
        FOO: foo
        BAR: bar
    )
    expect(confs.size).to eq 2
    expect(confs.map { |c| c['env']['global'] }).to eq 'FOO=foo BAR=bar'
  end

  it 'global and matrix given as arrays' do
    confs = matrix %(
      env:
        global:
          - FOO=foo
        matrix:
          - BAR=bar
          - BAZ=baz
    )
    expect(confs.size).to eq 2
    expect(confs.map { |c| c['env']['global'] }).to eq [%w(FOO=foo BAR=bar), %w(FOO=foo BAZ=baz)]
  end

  # TODO this is a consequence of config/env_spec.rb:25 'normalizes an env vars
  # hash to an array of strings' which i think should be supported and fixed
  xit 'global and matrix given as hashes' do
    confs = matrix %(
      env:
        global:
          FOO: foo
        matrix:
          BAR: bar
          BAZ: baz
    )
    expect(confs.size).to eq 2
    expect(confs.map { |c| c['env']['global'] }).to eq [%w(FOO=foo BAR=bar), %w(FOO=foo BAZ=baz)]
  end
end
