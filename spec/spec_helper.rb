require 'pry-byebug'
require 'rspec/its'
require 'capybara/rspec'
require 'capybara/poltergeist'
require_relative '../lib/monocle/url'

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers
  config.include Capybara::RSpecMatchers
  config.include Monocle::Url::RSpecHelpers
end

Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    phantomjs_logger: '/dev/null',
    js_errors: false
  )
end
