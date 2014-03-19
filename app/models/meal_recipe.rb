class MealRecipe < ActiveRecord::Base
  belongs_to :meal
  belongs_to :recipe

  validates :quantity, presence: true
end