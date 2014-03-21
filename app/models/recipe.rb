class Recipe < ActiveRecord::Base
  include Rateable
  
  has_many :meal_recipes, dependent: :destroy
  has_many :meals, through: :meal_recipes
  has_many :ratings, through: :meals

  validates :name, :url, presence: true
end
