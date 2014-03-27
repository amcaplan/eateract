class MealPerson < ActiveRecord::Base
  belongs_to :meal
  belongs_to :person

  before_save :generate_token

  def generate_token
    self.token = SecureRandom.urlsafe_base64(32)
  end
end