require_relative 'helper'

class TestEnteringComplexes < AptHuntTest
  def test_valid_apartment_saved
    complex = AptComplex.create(name: "Garden Terrace", zip: 37075, parking: "garage", website: "www.gardenterrace.com", phone: "555-555-5555")
    `./apt_hunter create apartment --rent 983.57 --size 1474 --bedrooms 3 --bathrooms 1.5 --complex 'Garden Terrace' --environment test`

    results = database.execute("select rent, size, bedrooms, bathrooms, complex_id from apartments")
    expected = [983.57, 1474, 3, 1.5, complex.id]
    assert_equal expected, results[0]

    result = database.execute("select count(id) from apartments")
    assert_equal 1, result[0][0]
  end
end