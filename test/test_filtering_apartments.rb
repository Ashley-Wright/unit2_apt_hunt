require_relative 'helper'

class TestFilteringApartments < AptHuntTest
  def test_filtering_apt_by_rent
    complex1 = AptComplex.create(name: "Garden Terrace", zip: 37075, parking: "garage", website: "www.gardenterrace.com", phone: "555-555-5555")

    apartment1 = Apartment.create(rent: 983.57, size: 1474, bedrooms: 3, bathrooms: 1.5, complex_id: complex1.id)
    apartment2 = Apartment.create(rent: 883.57, size: 1474, bedrooms: 3, bathrooms: 1.5, complex_id: complex1.id)
    apartment3 = Apartment.create(rent: 1003.57, size: 1474, bedrooms: 3, bathrooms: 1.5, complex_id: complex1.id)
    apartment4 = Apartment.create(rent: 953.57, size: 1474, bedrooms: 3, bathrooms: 1.5, complex_id: complex1.id)

    shell_output = `./apt_hunter filter apartment --min 900 --max 1000 --environment test`
    expected = <<EOS
#{apartment1.id}   $983.57   1474   0.667   3   1.5   Garden Terrace
#{apartment4.id}   $953.57   1474   0.647   3   1.5   Garden Terrace
EOS
  assert_equal expected, shell_output
  end

  def test_filtering_apt_by_rent_sort_by_bedrooms
    complex1 = AptComplex.create(name: "Garden Terrace", zip: 37075, parking: "garage", website: "www.gardenterrace.com", phone: "555-555-5555")

    apartment1 = Apartment.create(rent: 983.57, size: 1474, bedrooms: 2, bathrooms: 1.5, complex_id: complex1.id)
    apartment2 = Apartment.create(rent: 883.57, size: 1474, bedrooms: 2, bathrooms: 1.5, complex_id: complex1.id)
    apartment3 = Apartment.create(rent: 1003.57, size: 1474, bedrooms: 3, bathrooms: 1.5, complex_id: complex1.id)
    apartment4 = Apartment.create(rent: 953.57, size: 1474, bedrooms: 3, bathrooms: 1.5, complex_id: complex1.id)

    shell_output = `./apt_hunter filter apartment --min 900 --max 1000 --sort bedrooms --environment test`
    expected = <<EOS
#{apartment4.id}   $953.57   1474   0.647   3   1.5   Garden Terrace
#{apartment1.id}   $983.57   1474   0.667   2   1.5   Garden Terrace
EOS
  assert_equal expected, shell_output
  end

end