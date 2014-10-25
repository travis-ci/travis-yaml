describe Travis::Yaml::Parser::Psych do
  example "does not rely on visit_unexpected raising an exception" do
    expect { Travis::Yaml.load("cache: [bundler, { directories: [test/feature_files] }]") }.
      not_to raise_error
  end
end