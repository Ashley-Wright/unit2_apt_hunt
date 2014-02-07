class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
      t.integer :rent
      t.integer :size
      t.integer :bedrooms
      t.decimal :bathrooms
      t.integer :apartmentapartmentcomplex_id
    end
  end
end