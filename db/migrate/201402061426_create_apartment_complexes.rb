class CreateApartmentComplexes < ActiveRecord::Migration
  def change
    create_table :apartmentcomplexes do |t|
      t.string :name
      t.integer :zip
      t.string :parking
      t.string :website
      t.string :phone
    end
  end
end