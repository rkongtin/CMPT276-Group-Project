class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :address
      t.double :lat
      t.double :long

      t.timestamps null: false
    end
  end
end
