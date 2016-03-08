class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :address
      t.decimal :lat
      t.decimal :long

      t.timestamps null: false
    end
  end
end
