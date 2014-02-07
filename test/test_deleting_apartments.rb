require_relative 'helper'

class TestDeletingApartments < AptHuntTest
  def test_delete_apartment
    complex1 = ApartmentComplex.create(name: "Garden Terrace", zip: 37075, parking: "garage", website: "www.gardenterrace.com", phone: "555-555-5555")
    complex2 = ApartmentComplex.create(name: "Oak Village", zip: 37075, parking: "garage", website: "www.oakvillage.com", phone: "555-555-5556")

    apartment1 = Apartment.create(rent: 853.57, size: 1476, bedrooms: 3, bathrooms: 1.5, apartmentcomplex_id: complex1.id)
    apartment2 = Apartment.create(rent: 983.57, size: 1354, bedrooms: 3, bathrooms: 1.5, apartmentcomplex_id: complex2.id)
    apartment3 = Apartment.create(rent: 983.57, size: 1474, bedrooms: 3, bathrooms: 1.5, apartmentcomplex_id: complex2.id)

    `./apt_hunter delete apartment --id #{apartment2.id} --environment test`
    result = database.execute("select * from apartments where id = #{apartment2.id}")
    assert_equal [], result

    results = database.execute("select count(id) from apartments")
    assert_equal 2, results[0][0]
  end

end