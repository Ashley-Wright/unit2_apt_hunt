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

  def test_valid_apartment_message
    complex = AptComplex.create(name: "Garden Terrace", zip: 37075, parking: "garage", website: "www.gardenterrace.com", phone: "555-555-5555")
    shell_output = `./apt_hunter create apartment --rent 983.57 --size 1474 --bedrooms 3 --bathrooms 1.5 --complex 'Garden Terrace' --environment test`

    expected = <<EOS
Apartment was created.
$983.57   1474   3   1.5   Garden Terrace
EOS
    assert_equal expected, shell_output
  end

  def test_error_message_missing_rent
    command = "./apt_hunter create apartment"
    expected = "You must provide the rent, size, number of bedrooms, number of bathrooms and name of apartment complex."
    assert_command_output expected, command
  end

  def test_error_message_missing_size
    command = "./apt_hunter create apartment --rent 847.96"
    expected = "You must provide the size, number of bedrooms, number of bathrooms and name of apartment complex."
    assert_command_output expected, command
  end

  def test_error_message_missing_bedrooms
    command = "./apt_hunter create apartment --rent 847.96 --size 1157"
    expected = "You must provide the number of bedrooms, number of bathrooms and name of apartment complex."
    assert_command_output expected, command
  end

  def test_error_message_missing_bathrooms
    command = "./apt_hunter create apartment --rent 847.96 --size 1157 --bedrooms 2"
    expected = "You must provide the number of bathrooms and name of apartment complex."
    assert_command_output expected, command
  end

  def test_error_message_missing_complex
    command = "./apt_hunter create apartment --rent 847.96 --size 1157 --bedrooms 2 --bathrooms 1.5"
    expected = "You must provide the name of apartment complex."
    assert_command_output expected, command
  end

end