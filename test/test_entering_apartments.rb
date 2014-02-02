require_relative 'helper'

class TestEnteringComplexes < AptHuntTest
  def test_valid_apartment_saved
    skip
    `./apt_hunter create apartment --rent 983.57 --size 1474 --bedrooms 3 --bathrooms 1.5 --environment test`
    results = database.execute("select rent, size, bedrooms, bathrooms from apartments")
    expected = [983.57, 1474, 3, 1.5]
    assert_equal expected, results[0]

    result = database.execute("select count(id) from apartments")
    assert_equal 1, result[0][0]
  end
end