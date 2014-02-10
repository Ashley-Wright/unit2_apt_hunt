require_relative 'helper'

class TestDeletingApartments < AptHuntTest
  def test_delete_apartment
    complex1 = ApartmentComplex.new(name: "Garden Terrace", zip: 37075, parking: "garage", website: "www.gardenterrace.com", phone: "555-555-5555")
    complex1.save
    complex2 = ApartmentComplex.new(name: "Oak Village", zip: 37075, parking: "garage", website: "www.oakvillage.com", phone: "555-555-5556")
    complex2.save

    apartment1 = Apartment.new(rent: 853, size: 1476, bedrooms: 3, bathrooms: 1.5, apartmentapartmentcomplex_id: complex1.id)
    apartment1.save
    apartment2 = Apartment.new(rent: 983, size: 1354, bedrooms: 3, bathrooms: 1.5, apartmentapartmentcomplex_id: complex2.id)
    apartment2.save
    apartment3 = Apartment.new(rent: 983, size: 1474, bedrooms: 3, bathrooms: 1.5, apartmentapartmentcomplex_id: complex2.id)
    apartment3.save

    `./apt_hunter delete apartment --id #{apartment2.id} --environment test`
    result = Apartment.find_by(id: apartment2.id)
    assert_equal nil, result

    results = Apartment.count
    assert_equal 2, results
  end

end