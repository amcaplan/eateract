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
    time ? time.strftime('%A, %b %-d, %Y at %l:%M%p') : "an undetermined time"
  end

  def add_recipe(recipe)
    MealRecipe.create(meal: self, recipe: recipe)
  end

  def host
    people.where("meal_people.host_relationship" => "self")
  end

  def host=(new_host)
    MealPerson.create(person: new_host.person, meal: self, host: true,
      host_relationship: "self", attending: true)
  end

  def hosted_by?(person)
    person.id == people.where("meal_people.host_relationship" => "self").pluck(:id).first
  end

  def add_guests(guests, relationships)
    guests.each do |guest|
      MealPerson.create(person: guest, meal: self, host: false,
        host_relationship: relationships.shift)
    end
  end

  def guests
    Person.where(id: meal_people_guests.pluck(:person_id))
  end

  def meal_people_guests
    meal_people.where.not(host_relationship: "self")
  end

  def guest_count
    guests.size
  end

  def active_guest_count
    meal_people.where(attending: "NOT false").size
  end

  def guests_attending
    guests.where(id: meal_people.where(attending: true).pluck(:person_id))
  end

  def num_guests_attending
    guests_attending.size
  end

  def guests_not_attending
    guests.where(id: meal_people.where(attending: false).pluck(:person_id))
  end

  def num_guests_not_attending
    guests_not_attending.size
  end

  def guests_not_responded
    guests.where(id: meal_people.where(attending: nil).pluck(:person_id))
  end

  def num_guests_not_responded
    guests_not_responded.size
  end

  def unclaimed_recipes
    Recipe.where(id: meal_recipes.where(person_id: nil).pluck(:recipe_id)).all
  end

  def claimed_meal_recipes
    meal_recipes.where.not(person_id: nil).all
  end
end