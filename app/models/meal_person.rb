class MealPerson < ActiveRecord::Base
  belongs_to :meal
  belongs_to :person

  before_save :generate_token, :attend_if_host

  def generate_token
    self.token = SecureRandom.urlsafe_base64(32) unless self.persisted?
  end

  def attend_if_host
    self.attending = true if self.host_relationship == "self"
  end
end