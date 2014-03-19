# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end

def let_statements
  let (:person) {
    p = Person.create(name: "Ariel Caplan", email: "fake_email@aol.com")
    p.save
    p.reload
  }
  let (:recipe1) {
    r = Recipe.create(name: "steak", cuisine_type: "American", url: "example.com")
    r.save
    r.reload
  }
  let (:recipe2) {
    r = Recipe.create(name: "French fries", cuisine_type: "American", url: "example2.com/fries")
    r.save
    r.reload
  }
  let (:topic1) {
    t = Topic.create(name: "Global Warming")
    t.save
    t.reload
  }
  let (:meal1) {
    m = Meal.create(time: Time.now, cuisine_type: "American")
    m.save
    m.topic = topic1
    m.add_recipe(recipe1)
    m.save
    m.reload
  }
  let (:meal2) {
    m = Meal.create(time: Time.now)
    m.save
    m.reload
  }
  let (:mealperson1) {
    mp = MealPerson.create(host: true, host_relationship: 'self', person: person, meal: meal1)
    mp.save
    mp.reload
  }
  let (:mealperson2) {
    mp = MealPerson.create(host: false, host_relationship: 'family', person: person, meal: meal2)
    mp.save
    mp.reload
  }
  let (:rating1) {
    r = Rating.create(person: person, number: 4.5, meal: meal1)
    r.save
    r.reload
  }
  let (:rating2) {
    r = Rating.create(person: person, number: 4, meal: meal2)
    r.save
    r.reload
  }
  let (:rating3) {
    r = Rating.create(number: 4, meal: meal1)
    r.save
    r.reload
  }
end