class Link < ActiveRecord::Base
  include Rateable
  
  has_many :topic_links, dependent: :destroy
  has_many :topics, through: :topic_links
  has_many :meal_links, dependent: :destroy
  has_many :meals, through: :meal_links
  has_many :ratings, through: :meals

  validates :url, presence: true
end
