class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer :user_id
      t.integer :event_type_id
      t.string :twitter_status_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
