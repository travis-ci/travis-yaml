describe Travis::Yaml::Serializer::Yaml do
  subject(:config) { Travis::Yaml.parse('env: [{ secure: "foo" }, "bar"]') }

  example "serializes json" do
    expect(config.serialize(:yaml).gsub("'", "")).to be ==
      "---\nenv:\n  matrix:\n  - !encrypted foo\n  - bar\nlanguage: ruby\nos:\n- linux\n"
  end

  example "complains about decrypted values missing" do
    expect { config.serialize(:yaml, secure: :decrypted) }.to raise_error(ArgumentError,
      'secure option is set decrypted, but a secure value is not decrypted')
  end

  example "serializes decrypted values" do
    config.decrypt { |*| "x" }

    expect(config.serialize(:yaml, secure: :encrypted).gsub("'", "")).to be ==
      "---\nenv:\n  matrix:\n  - !encrypted foo\n  - bar\nlanguage: ruby\nos:\n- linux\n"

    expect(config.serialize(:yaml, secure: :decrypted).gsub("'", "")).to be ==
      "---\nenv:\n  matrix:\n  - !decrypted x\n  - bar\nlanguage: ruby\nos:\n- linux\n"
  end

  example "avoid tags" do
    config.decrypt { |*| "x" }

    expect(config.serialize(:yaml, secure: :encrypted, avoid_tags: true).gsub("'", "")).to be ==
      "---\nenv:\n  matrix:\n  - secure: foo\n  - bar\nlanguage: ruby\nos:\n- linux\n"

    expect(config.serialize(:yaml, secure: :decrypted, avoid_tags: true).gsub("'", "")).to be ==
      "---\nenv:\n  matrix:\n  - x\n  - bar\nlanguage: ruby\nos:\n- linux\n"
  end

  example "indentation" do
    expect(config.serialize(:yaml, indentation: 3).gsub("'", "")).to be ==
      "---\nenv:\n   matrix:\n   - !encrypted foo\n   - bar\nlanguage: ruby\nos:\n- linux\n"
  end

  example "symbol keys" do
    expect(config.serialize(:yaml, symbol_keys: true).gsub("'", "")).to be ==
      "---\n:env:\n  :matrix:\n  - !encrypted foo\n  - bar\n:language: ruby\n:os:\n- linux\n"
  end

  example "is exposed via to_yaml" do
    expect(config.serialize(:yaml)).to be == config.to_yaml
  end
end