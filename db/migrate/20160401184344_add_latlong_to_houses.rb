class AddLatlongToHouses < ActiveRecord::Migration
  def change
    add_column :houses, :lat, :float
    add_column :houses, :long, :float
  end
end
