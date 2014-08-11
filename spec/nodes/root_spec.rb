describe Travis::Yaml::Nodes::Root do
  describe "from YAML" do
    context "double entry" do
      subject :yaml do
        Travis::Yaml.parse <<-YAML.gsub(/^ {10}/, '')
          addons:
            postgresql: "9.3"
          addons:
            code_climate:
              api_token: "foobar"
        YAML
      end

      let :warnings do
        subject.warnings
      end

      specify "warns about double entries" do
        expect(warnings).to include('has multiple "addons" entries, keeping last entry')
      end
    end
  end
end