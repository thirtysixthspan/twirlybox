class Pattern < ActiveRecord::Base
  set_table_name 'patterns'

  belongs_to :event_type
  
  def self.init_table
    if !Pattern.table_exists?
      ActiveRecord::Schema.define do
        create_table :patterns do |t|
          t.column :regex, :string
          t.column :event_type_id, :integer
        end
      end
    end
  end

  def self.reset_table
    if Pattern.table_exists?
      ActiveRecord::Schema.define do
        drop_table :patterns
      end
    end
    init_table      
  end
end

class EventType < ActiveRecord::Base
  set_table_name 'event_types'

  has_many :patterns
  has_many :events
  belongs_to :icon

  def self.init_table
    if !EventType.table_exists?
      ActiveRecord::Schema.define do
        create_table :event_types do |t|
          t.column :name, :string
          t.column :icon_id, :integer  
          t.column :icon_type_id, :integer
          t.column :parse_method, :text      
        end
      end
    end
  end

  def self.reset_table
    if Pattern.table_exists?
      ActiveRecord::Schema.define do
        drop_table :event_types
      end
    end
    init_table      
  end
end


class Event < ActiveRecord::Base
  set_table_name 'events'

  belongs_to :event_type
 
  def self.init_table
    if !Event.table_exists?
      ActiveRecord::Schema.define do
        create_table :events do |t|
          t.column :user_id, :integer
          t.column :event_type_id, :integer          
          t.column :twitter_status_id, :integer        
        end
      end
    end
  end

  def self.reset_table
    if Pattern.table_exists?
      ActiveRecord::Schema.define do
        drop_table :events
      end
    end
    init_table      
  end
end


class User < ActiveRecord::Base
  set_table_name 'users'

  has_many :events
 
  def self.init_table
    if !User.table_exists?
      ActiveRecord::Schema.define do
        create_table :users do |t|
          t.column :twitter_id, :string
          t.column :twitter_name, :string
        end
      end
    end
  end

  def self.reset_table
    if Pattern.table_exists?
      ActiveRecord::Schema.define do
        drop_table :users
      end
    end
    init_table      
  end
end


class IconType < ActiveRecord::Base
  set_table_name 'icon_types'

  has_many :icons

  def self.init_table
    if !IconType.table_exists?
      ActiveRecord::Schema.define do
        create_table :icon_types do |t|
          t.column :name, :string
          t.column :picture, :string
          t.column :url, :string
        end
      end
    end
  end

  def self.reset_table
    if Pattern.table_exists?
      ActiveRecord::Schema.define do
        drop_table :icon_types
      end
    end
    init_table      
  end
end

class Icon < ActiveRecord::Base
  set_table_name 'icons'

  has_one :event_type
  has_one :icon_type

  def self.init_table
    if !Icon.table_exists?
      ActiveRecord::Schema.define do
        create_table :icons do |t|
          t.column :name, :string
          t.column :picture, :string
          t.column :url, :string
          t.column :icon_type_id, :integer
        end
      end
    end
  end

  def self.reset_table
    if Pattern.table_exists?
      ActiveRecord::Schema.define do
        drop_table :icons
      end
    end
    init_table      
  end
end




