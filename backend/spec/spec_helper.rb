# frozen_string_literal: true

require_relative '../lib/drivy'
require 'simplecov'
SimpleCov.start

Dir["#{__dir__}/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before do
    Drivy::BaseRepository.reset_all_subclasses!
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
