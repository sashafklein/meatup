require 'rubygems'
require 'factory_girl'
FactoryGirl.find_definitions

# Loading more in this block will cause your tests to run faster. However, 
# if you change any configuration or code from libraries loaded here, you'll
# need to restart spork for it take effect.
# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.color_enabled = true

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # memory settings
    config.before(:all) do
      DeferredGarbageCollection.start
    end

    config.after(:all) do
      DeferredGarbageCollection.reconsider
    end

    config.before(:selenium => true) do
      Capybara.current_driver = :chrome
      DatabaseCleaner.strategy = :truncation
    end

    config.after(:selenium => true) do
      Capybara.current_driver = :webkit
      DatabaseCleaner.strategy = :transaction
    end

    # Database Cleaner
    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation) #clean once with truncation
    end

    # Use truncation strategy for JS tests
    config.before(:js => true) do
      DatabaseCleaner.strategy = :truncation
    end

    # Switch back to transaction
    config.after(:js => true) do
      DatabaseCleaner.strategy = :transaction
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end
end

def create_some_cuts
  return false if  @ground.present?
  %w(ground london stew filet bacon).map(&:to_sym).each do |cut_factory|
    instance_variable_set "@#{cut_factory}", FactoryGirl.create(cut_factory)
  end
end