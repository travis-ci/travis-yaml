describe Travis::Yaml::Serializer::Legacy do
  subject(:config) { Travis::Yaml.parse('env: [{ secure: "foo" }, "bar"]') }

  example "serializes to legacy ruby" do
    expect(config.serialize(:legacy)).to be == {
      "env"=>{"matrix"=>[{"secure"=>"foo"}, "bar"]},
      "language"=>"ruby", "os"=>["linux"],
      ".result"=>"configured",
      ".result_warnings"=>[[[], "missing key \"language\", defaulting to \"ruby\""]]
    }
  end

  example "serializes to legacy ruby" do
    expect(config.serialize(:legacy, symbol_keys: true)).to be == {
      :env=>{:matrix=>[{:secure=>"foo"}, "bar"]},
      :language=>"ruby", :os=>["linux"],
      :".result"=>"configured",
      :".result_warnings"=>[[[], "missing key \"language\", defaulting to \"ruby\""]]
    }
  end

  example "complains about decrypted values missing" do
    expect { config.serialize(:legacy, secure: :decrypted) }.to raise_error(ArgumentError, 'secure option is set decrypted, but a secure value is not decrypted')
  end

  example "serializes decrypted values" do
    config.decrypt { |*| "x" }

    expect(config.serialize(:legacy, secure: :encrypted)).to be == {
      "env"=>{"matrix"=>[{"secure"=>"foo"}, "bar"]},
      "language"=>"ruby", "os"=>["linux"],
      ".result"=>"configured",
      ".result_warnings"=>[[[], "missing key \"language\", defaulting to \"ruby\""]]
    }

    expect(config.serialize(:legacy, secure: :decrypted)).to be == {
      "env"=>{"matrix"=>["x", "bar"]},
      "language"=>"ruby", "os"=>["linux"],
      ".result"=>"configured",
      ".result_warnings"=>[[[], "missing key \"language\", defaulting to \"ruby\""]]
    }
  end

  example "is exposed via to_legacy_ruby" do
    expect(config.serialize(:legacy)).to be == config.to_legacy_ruby
  end
end