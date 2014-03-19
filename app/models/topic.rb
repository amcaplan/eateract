class Topic < ActiveRecord::Base
  include Rateable
  
  has_many :topic_links
  has_many :links, through: :topic_links

  has_many :meals
  has_many :ratings, through: :meals

  validates :name, presence: true
end
