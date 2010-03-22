class CreateIcons < ActiveRecord::Migration
  def self.up
    create_table :icons do |t|
      t.string :name
      t.string :picture
      t.string :url
      t.integer :icon_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :icons
  end
end
