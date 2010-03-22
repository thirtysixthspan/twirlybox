class CreateItemTypes < ActiveRecord::Migration
  def self.up
    create_table :item_types do |t|
      t.string :name
      t.integer :icon_id
      t.integer :price
      t.text :action_method

      t.timestamps
    end
  end

  def self.down
    drop_table :item_types
  end
end
