class MealPerson < ActiveRecord::Base
  belongs_to :meal
  belongs_to :person
end
