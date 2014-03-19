class Recipe < ActiveRecord::Base
  has_many :meal_recipes
  has_many :meals, through: :meal_recipes
  has_many :ratings, through: :meals

  validates :name, :url, presence: true
end
