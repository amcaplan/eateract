class MealLink < ActiveRecord::Base
  belongs_to :meal
  belongs_to :link
end