require_relative 'helper'

class TestViewingComplexes < AptHuntTest
  def test_viewing_all_complexes
    complex1 = ApartmentComplex.create(name: "Garden Terrace", zip: 37075, parking: "garage", website: "www.gardenterrace.com", phone: "555-555-5555")
    complex2 = ApartmentComplex.create(name: "Oak Village", zip: 37075, parking: "garage", website: "www.oakvillage.com", phone: "555-555-5556")
    complex3 = ApartmentComplex.create(name: "Eagle Point", zip: 37075, parking: "uncovered", website: "www.eaglepoint.com", phone: "555-555-5557")

    shell_output = `./apt_hunter view complex --environment test`
    expected = <<EOS
Eagle Point   #{complex3.id}   37075   uncovered   www.eaglepoint.com   555-555-5557
Garden Terrace   #{complex1.id}   37075   garage   www.gardenterrace.com   555-555-5555
Oak Village   #{complex2.id}   37075   garage   www.oakvillage.com   555-555-5556
EOS
    assert_equal expected, shell_output
  end

  def test_viewing_complexes_empty_table
    results = ApartmentComplex.all
    assert_equal [], results
  end
end