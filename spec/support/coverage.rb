require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start do
  project_name 'travis-yaml'
  coverage_dir '.coverage'

  add_filter "/spec/"
  add_group 'Library', 'lib'
end
