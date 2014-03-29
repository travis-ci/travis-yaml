unless defined? RUBY_ENGINE and RUBY_ENGINE == 'jruby'
  require 'simplecov'
  SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter

  SimpleCov.start do
    project_name 'travis-yaml'
    coverage_dir '.coverage'
    add_filter '/spec/'
    add_group 'Library', 'lib'
  end
end
