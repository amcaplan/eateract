class Person < ActiveRecord::Base
  has_many :users
  has_many :ratings
  has_many :meal_people
  has_many :meals, through: :meal_people

  validates :name, :email, presence: true

  def hosting(meal)
    meal_people.where(host: true).meals.include?(meal)
  end
end
