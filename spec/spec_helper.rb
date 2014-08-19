require 'awesome_zanox'
require 'rspec'
require 'savon/mock/spec_helper'

RSpec.configure do |config|
  include Savon::SpecHelper
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end  
end

def fixture(file)
  File.read('spec/fixtures/' + file)
end
