module Rateable
  module ClassMethods
    def average_rating
      ratings = self.all.ratings
      ratings.inject(&:+) / ratings.size
    end
  end
  
  module InstanceMethods
    def average_rating
      ratings = self.ratings.map(&:number)
      ratings.inject(&:+) / ratings.size
    end
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end