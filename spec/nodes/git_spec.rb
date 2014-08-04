describe Travis::Yaml::Nodes::Git do
  context 'from Ruby' do
    describe :depth do
      specify 'is integer' do
        expect(Travis::Yaml.parse(git: { depth: 42 }).git.depth).to be == 42
      end

      specify 'complains about non-integer values' do
        expect(Travis::Yaml.parse(git: { depth: "foo" }).nested_warnings).to \
          include([['git'], 'dropping "depth" section: "str" not supported, dropping "foo"'])
      end
    end

    describe :submodules do
      specify 'is integer' do
        expect(Travis::Yaml.parse(git: { submodules: false }).git.submodules).to be == false
      end

      specify 'complains about non-integer values' do
        expect(Travis::Yaml.parse(git: { submodules: "foo" }).nested_warnings).to \
          include([['git'], 'dropping "submodules" section: "str" not supported, dropping "foo"'])
      end
    end

    describe :strategy do
      specify 'can be clone' do
        expect(Travis::Yaml.parse(git: { strategy: :clone }).git.strategy).to be == "clone"
      end

      specify 'can be tarball' do
        expect(Travis::Yaml.parse(git: { strategy: :tarball }).git.strategy).to be == "tarball"
      end

      specify 'cannot be foo' do
        expect(Travis::Yaml.parse(git: { strategy: :foo }).nested_warnings).to \
          include([['git'], 'dropping "strategy" section: illegal value "foo"'])
      end
    end
  end

  context 'from YAML' do
    describe :depth do
      specify 'is integer' do
        expect(Travis::Yaml.parse("git: { depth: 42 }").git.depth).to be == 42
      end

      specify 'complains about non-integer values' do
        expect(Travis::Yaml.parse('git: { depth: !str foo }').nested_warnings).to \
          include([['git'], 'dropping "depth" section: "str" not supported, dropping "foo"'])
        expect(Travis::Yaml.parse('git: { depth: foo }').nested_warnings).to \
          include([['git'], 'dropping "depth" section: failed to parse "int" - invalid value for Integer: "foo"'])
      end
    end
  end
end
