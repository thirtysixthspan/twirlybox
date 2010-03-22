class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.integer :user_id
      t.integer :item_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
