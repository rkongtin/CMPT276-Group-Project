class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :address
      t.integer :price
      t.integer :sqft
      t.text :amenities
      t.integer :contact_info
      t.string :pictures

      t.timestamps null: false
    end
  end
end
