describe Travis::Yaml::Nodes::Root do
  let :warnings do
    subject.warnings
  end

  describe "from YAML" do
    context "sudo" do
      subject :yaml do
        Travis::Yaml.parse <<-YAML.gsub(/^ {10}/, '')
          language: ruby
          sudo: false
        YAML
      end

      specify "gives no warnings" do
        expect(warnings).to be_empty
      end
    end

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

      specify "warns about double entries" do
        expect(warnings).to include('has multiple "addons" entries, keeping last entry')
      end
    end
  end
end
