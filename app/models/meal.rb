class Meal < ActiveRecord::Base
  include Rateable
  
  has_many :meal_people
  has_many :people, through: :meal_people
  has_many :users, through: :people

  has_many :ratings

  has_many :meal_links
  has_many :links, through: :meal_links

  has_many :meal_recipes
  has_many :recipes, through: :meal_recipes

  belongs_to :topic

  validates :time, presence: true

  def add_recipe(recipe, quantity = 1)
    MealRecipe.create(meal: self, recipe: recipe, quantity: quantity)
  end
end
