require_relative 'helper'

class TestViewingApartments < AptHuntTest

  def test_viewing_all_apartments
    complex1 = AptComplex.create(name: "Garden Terrace", zip: 37075, parking: "garage", website: "www.gardenterrace.com", phone: "555-555-5555")
    complex2 = AptComplex.create(name: "Oak Village", zip: 37075, parking: "garage", website: "www.oakvillage.com", phone: "555-555-5556")
    complex3 = AptComplex.create(name: "Eagle Point", zip: 37075, parking: "uncovered", website: "www.eaglepoint.com", phone: "555-555-5557")

    apartment1 = Apartment.create(rent: 983.57, size: 1474, bedrooms: 3, bathrooms: 1.5, complex_id: complex1.id)
    apartment2 = Apartment.create(rent: 983.57, size: 1474, bedrooms: 3, bathrooms: 1.5, complex_id: complex2.id)
    apartment3 = Apartment.create(rent: 983.57, size: 1474, bedrooms: 3, bathrooms: 1.5, complex_id: complex3.id)
    apartment4 = Apartment.create(rent: 983.57, size: 1374, bedrooms: 3, bathrooms: 1.5, complex_id: complex3.id)

    shell_output = `./apt_hunter view apartment --environment test`
    expected = <<EOS
$983.57   1474   3   1.5   Eagle Point
$983.57   1374   3   1.5   Eagle Point
$983.57   1474   3   1.5   Garden Terrace
$983.57   1474   3   1.5   Oak Village
EOS
  assert_equal expected, shell_output
  end

end