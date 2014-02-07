require_relative 'helper'

class TestUpdatingApartments < AptHuntTest
  def test_updating_existing_record_single_field
    complex = ApartmentComplex.create(name: "Garden Terrace", zip: 37075, parking: "garage", website: "www.gardenterrace.com", phone: "555-555-5555")
    apartment = Apartment.create(rent: 853.57, size: 1476, bedrooms: 3, bathrooms: 1.5, apartmentcomplex_id: complex.id)

    command = "./apt_hunter edit apartment --id #{apartment.id} --bedrooms 2 --environment test"
    expected = <<EOS.chomp
Apartment #{apartment.id} was updated.
$853.57   1476   2   1.5   Garden Terrace
EOS
    assert_command_output expected, command
  end

  def test_updating_existing_record_multiple_fields
    complex1 = ApartmentComplex.create(name: "Garden Terrace", zip: 37075, parking: "garage", website: "www.gardenterrace.com", phone: "555-555-5555")
    complex2 = ApartmentComplex.create(name: "Eagle Point", zip: 37075, parking: "garage", website: "www.gardenterrace.com", phone: "555-555-5555")
    apartment = Apartment.create(rent: 853.57, size: 1476, bedrooms: 3, bathrooms: 1.5, apartmentcomplex_id: complex1.id)

    command = "./apt_hunter edit apartment --id #{apartment.id} --rent 953.57 --size 1398 --bedrooms 2 --bathrooms 2 --environment test"
    expected = <<EOS.chomp
Apartment #{apartment.id} was updated.
$953.57   1398   2   2   Garden Terrace
EOS
    assert_command_output expected, command
  end

  def test_attempting_to_update_a_nonexistant_record
    command = "./apt_hunter edit apartment --id 218903123980123  --rent 900.40 --size 1300 --bedrooms 2 --bathrooms 1.5 --environment test"
    expected = "Apartment 218903123980123 does not exist."
    assert_command_output expected, command
  end
end