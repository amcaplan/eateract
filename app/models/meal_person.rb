class MealPerson < ActiveRecord::Base
  belongs_to :meal
  belongs_to :person

  validates :host_relationship, presence: true
  validates_inclusion_of :host, :in => [true, false]
end
