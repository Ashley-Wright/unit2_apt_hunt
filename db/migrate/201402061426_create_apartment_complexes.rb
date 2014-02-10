class CreateApartmentComplexes < ActiveRecord::Migration
  def change
    create_table :apartment_complexes do |t|
      t.string :name
      t.integer :zip
      t.string :parking
      t.string :website
      t.string :phone
    end
  end
end