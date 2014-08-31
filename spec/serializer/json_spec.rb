describe Travis::Yaml::Serializer::Json do
  subject(:config) { Travis::Yaml.parse('env: [{ secure: "foo" }, "bar"]') }

  example "serializes json" do
    expect(config.serialize(:json)).to be == '{"env":{"matrix":[{"secure":"foo"},"bar"]},"language":"ruby","os":["linux"]}'
  end

  example "does work properly with symbol keys option" do
    expect(config.serialize(:json, symbol_keys: true)).to be == '{"env":{"matrix":[{"secure":"foo"},"bar"]},"language":"ruby","os":["linux"]}'
  end

  example "serializes pretty json" do
    expect(config.serialize(:json, pretty: true)).to be ==
      "{\n  \"env\": {\n    \"matrix\": [\n      {\"secure\": \"foo\"},\n      \"bar\"\n    ]\n  },\n  \"language\": \"ruby\",\n  \"os\": [ \"linux\" ]\n}"
  end

  example "complains about decrypted values missing" do
    expect { config.serialize(:json, secure: :decrypted) }.to raise_error(ArgumentError, 'secure option is set decrypted, but a secure value is not decrypted')
  end

  example "serializes decrypted values" do
    config.decrypt { |*| "x" }
    expect(config.serialize(:json, secure: :encrypted)).to be == '{"env":{"matrix":[{"secure":"foo"},"bar"]},"language":"ruby","os":["linux"]}'
    expect(config.serialize(:json, secure: :decrypted)).to be == '{"env":{"matrix":["x","bar"]},"language":"ruby","os":["linux"]}'
  end

  example "is exposed via to_json" do
    expect(config.serialize(:json)).to be == config.to_json
  end
end