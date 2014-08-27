describe Travis::Yaml::Serializer::Ruby do
  subject(:config) { Travis::Yaml.parse('env: [{ secure: "foo" }, "bar"]') }

  example "serializes json" do
    expect(config.serialize(:ruby)).to be == {
      "env"=>{"matrix"=>[Travis::Yaml::SecureString.new("foo"), "bar"]},
      "language"=>"ruby", "os"=>["linux"]
    }
  end

  example "is exposed via to_ruby" do
     expect(config.serialize(:ruby)).to be == config.to_ruby
  end
end