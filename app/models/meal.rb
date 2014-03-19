class Meal < ActiveRecord::Base
  has_many :meal_people
  has_many :people, through: :meal_people
  has_many :users, through: :people

  has_many :ratings

  has_many :meal_links
  has_many :links, through: :meal_links

  belongs_to :topic

  validates :time, presence: true
end
