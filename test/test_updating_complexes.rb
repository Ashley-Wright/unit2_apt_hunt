require_relative 'helper'
require_relative '../lib/apt_complex'

class TestUpdatingComplexes < AptHuntTest
  def test_updating_existing_record
    complex = AptComplex.new(name: "Eagle Point", zip: 37075, parking: "covered", website: "www.eaglepoint.com", phone: "555-555-5555")
    complex.create("test")
    id = complex.id
    command = "./apt_hunter edit --id #{id} --key 'name' --value 'Eagle Pointe' --environment test"
    expected = "Complex #{id} was updated."
    assert_command_output expected, command
  end
end