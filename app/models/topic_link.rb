class TopicLink < ActiveRecord::Base
  belongs_to :topic
  belongs_to :link
end
