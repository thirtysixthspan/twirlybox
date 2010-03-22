class EventType < ActiveRecord::Base

  has_many :patterns
  has_many :events
  belongs_to :icon

end
