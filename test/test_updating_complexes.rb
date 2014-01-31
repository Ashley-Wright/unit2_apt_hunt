require_relative 'helper'
require_relative '../lib/apt_complex'

class TestUpdatingComplexes < AptHuntTest

  def test_updating_existing_record
    complex = AptComplex.new(name: "Eagle Point", zip: 37075, parking: "covered", website: "www.eaglepoint.com", phone: "555-555-5555")
    complex.save
    id = complex.id
    command = "./apt_hunter edit --id #{id} --name 'Eagle Pointe' --environment test"
    expected = <<EOS.chomp
Complex #{id} was updated.
Eagle Pointe   #{id}   37075   covered   www.eaglepoint.com   555-555-5555
EOS
    assert_command_output expected, command
  end
end