class Meal < ActiveRecord::Base
  include Rateable
  
  has_many :meal_people, dependent: :destroy
  has_many :people, through: :meal_people
  has_many :users, through: :people

  has_many :ratings

  has_many :meal_links, dependent: :destroy
  has_many :links, through: :meal_links

  has_many :meal_recipes, dependent: :destroy
  has_many :recipes, through: :meal_recipes

  belongs_to :topic

  def time_string
    time.strftime('%A, %b %-d, %Y at %l:%M%p')
  end

  def add_recipe(recipe, quantity = 1)
    MealRecipe.create(meal: self, recipe: recipe, quantity: quantity)
  end

  def host
    people.where("meal_people.host" => true)
  end

  def host=(new_host)
    MealPerson.create(person: new_host.person, meal: self, host: true,
      host_relationship: "self", attending: true)
  end

  def hosted_by?(person)
    person.id == people.where("meal_people.host" => true).pluck(:id).first
  end

  def add_guests(guests, relationships)
    guests.each do |guest|
      MealPerson.create(person: guest, meal: self, host: false,
        host_relationship: relationships.shift)
    end
  end

  def active_guest_count
    meal_people.where(attending: "NOT false").size
  end

  def guests_attending
    meal_people.where(attending: true)
  end

  def num_guests_attending
    guests_attending.size
  end

  def guests_not_attending
    meal_people.where(attending: false)
  end

  def num_guests_not_attending
    guests_not_attending.size
  end

  def guests_not_responded
    meal_people.where(attending: nil)
  end

  def num_guests_not_responded
    guests_not_responded.size
  end
end