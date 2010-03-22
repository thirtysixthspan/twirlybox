class CreatePatterns < ActiveRecord::Migration
  def self.up
    create_table :patterns do |t|
      t.string :regex
      t.integer :event_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :patterns
  end
end
