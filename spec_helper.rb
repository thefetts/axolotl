require 'rspec'
require 'rspec/autorun'

RSpec.configure do |c|
  c.filter_run :focus
  c.run_all_when_everything_filtered = true
  c.default_formatter = 'doc'
  c.order = :random
end