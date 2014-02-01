require_relative 'helper'
require_relative '../models/apt_complex'

class TestUpdatingComplexes < AptHuntTest

  def test_updating_existing_record_single_field
    complex = AptComplex.new(name: "Eagle Point", zip: 37075, parking: "covered", website: "www.eaglepoint.com", phone: "555-555-5555")
    complex.save
    id = complex.id
    command = "./apt_hunter edit complex --id #{id} --name 'Eagle Pointe' --environment test"
    expected = <<EOS.chomp
Complex #{id} was updated.
Eagle Pointe   #{id}   37075   covered   www.eaglepoint.com   555-555-5555
EOS
    assert_command_output expected, command
  end

  def test_updating_existing_record_multiple_fields
    complex = AptComplex.new(name: "Eagle Point", zip: 37075, parking: "covered", website: "www.eaglepoint.com", phone: "555-555-5555")
    complex.save
    id = complex.id
    command = "./apt_hunter edit complex --id #{id} --name 'Eagle Pointe' --zip 37074 --parking garage --website 'www.eaglepointe.com' --phone '555-555-5556' --environment test"
    expected = <<EOS.chomp
Complex #{id} was updated.
Eagle Pointe   #{id}   37074   garage   www.eaglepointe.com   555-555-5556
EOS
    assert_command_output expected, command
  end

  def test_attempting_to_update_a_nonexistant_record
    command = "./apt_hunter edit complex --id 218903123980123 --name 'Eagle Pointe' --environment test"
    expected = "Complex 218903123980123 does not exist."
    assert_command_output expected, command
  end
end