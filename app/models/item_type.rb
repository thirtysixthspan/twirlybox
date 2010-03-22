class ItemType < ActiveRecord::Base
  
    has_many :items
    belongs_to :icon

end
