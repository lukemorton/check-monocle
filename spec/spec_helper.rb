require 'pry-byebug'

require 'capybara/rspec'
require 'capybara/poltergeist'
Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, timeout: 10, phantomjs_logger: '/dev/null')
end
