require_relative 'helper'

class TestViewingApartments < AptHuntTest

  def test_viewing_all_apartments
    complex1 = ApartmentComplex.new(name: "Garden Terrace", zip: 37075, parking: "garage", website: "www.gardenterrace.com", phone: "555-555-5555")
    complex1.save
    complex2 = ApartmentComplex.new(name: "Oak Village", zip: 37075, parking: "garage", website: "www.oakvillage.com", phone: "555-555-5556")
    complex2.save
    complex3 = ApartmentComplex.new(name: "Eagle Point", zip: 37075, parking: "uncovered", website: "www.eaglepoint.com", phone: "555-555-5557")
    complex3.save

    apartment1 = Apartment.new(rent: 853.57, size: 1476, bedrooms: 3, bathrooms: 1.5, apartmentapartmentcomplex_id: complex1.id)
    apartment1.save
    apartment2 = Apartment.new(rent: 983.57, size: 1354, bedrooms: 3, bathrooms: 1.5, apartmentapartmentcomplex_id: complex2.id)
    apartment2.save
    apartment3 = Apartment.new(rent: 983.57, size: 1474, bedrooms: 3, bathrooms: 1.5, apartmentapartmentcomplex_id: complex3.id)
    apartment3.save
    apartment4 = Apartment.new(rent: 783.57, size: 1374, bedrooms: 3, bathrooms: 1.5, apartmentapartmentcomplex_id: complex3.id)
    apartment4.save

    shell_output = `./apt_hunter view apartment --environment test`
    expected = <<EOS
#{apartment4.id}   $783   1374   3   1.5   Eagle Point
#{apartment1.id}   $853   1476   3   1.5   Garden Terrace
#{apartment2.id}   $983   1354   3   1.5   Oak Village
#{apartment3.id}   $983   1474   3   1.5   Eagle Point
EOS
  assert_equal expected, shell_output
  end

end