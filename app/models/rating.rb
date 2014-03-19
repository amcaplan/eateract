class Rating < ActiveRecord::Base
  belongs_to :meal
  belongs_to :person

  validates :number, presence: true
end
