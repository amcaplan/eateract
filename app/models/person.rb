class Person < ActiveRecord::Base
  include Rateable
  
  has_one :user
  has_many :ratings
  has_many :meal_people, dependent: :destroy
  has_many :meals, through: :meal_people

  validates :name, :email, presence: true

  def hosting(meal)
    meal_people.where(host: true).meals.include?(meal)
  end
end
