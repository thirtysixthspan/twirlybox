class CreateEventTypes < ActiveRecord::Migration
  def self.up
    create_table :event_types do |t|
      t.string :name
      t.integer :icon_id
      t.integer :icon_type_id
      t.text :parse_method

      t.timestamps
    end
  end

  def self.down
    drop_table :event_types
  end
end
