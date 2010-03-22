class Icon < ActiveRecord::Base

  has_one :event_type
  belongs_to :icon_type
  
end
