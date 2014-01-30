require_relative 'helper'

class TestViewingComplexes < AptHuntTest
  def test_viewing_all_complexes
    `./apt_hunter create complex --name 'Garden Terrace' --zip 37075 --parking garage --website 'www.gardenterrace.com' --phone '555-555-5555' --environment test`
    `./apt_hunter create complex --name 'Oak Village' --zip 37075 --parking garage --website 'www.oakvillage.com' --phone '555-555-5556' --environment test`
    `./apt_hunter create complex --name 'Eagle Point' --zip 37075 --parking uncovered --website 'www.eaglepoint.com' --phone '555-555-5557' --environment test`

    shell_output = `./apt_hunter view complex --environment test`
    # expected = [["Garden Terrace", 37075, "garage", "www.gardenterrace.com", "555-555-5555"], ["Oak Village", 37075, "garage", "www.hickoryvillage.com", "555-555-5556"], ["Eagle Point", 37075, "uncovered", "www.eaglepoint.com", "555-555-5557"]]
    expected = <<EOS
Garden Terrace:   37075   garage   www.gardenterrace.com   555-555-5555
Oak Village:   37075   garage   www.oakvillage.com   555-555-5556
Eagle Point:   37075   uncovered   www.eaglepoint.com   555-555-5557
EOS
    assert_equal expected, shell_output
  end

  def test_viewing_complexes_empty_table
    results = database.execute("select name, zip, parking, website, phone from complexes")
    assert_equal [], results
  end
end