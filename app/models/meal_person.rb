class MealPerson < ActiveRecord::Base
  belongs_to :meal
  belongs_to :person

  validates :host, :host_relationship, presence: true
end
