class CreateIconTypes < ActiveRecord::Migration
  def self.up
    create_table :icon_types do |t|
      t.string :name
      t.string :picture
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :icon_types
  end
end
