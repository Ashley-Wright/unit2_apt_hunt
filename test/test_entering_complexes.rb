require_relative 'helper'

class TestEnteringComplexes < AptHuntTest
  def test_error_message_missing_name
    command = "./apt_hunter create complex"
    expected = "You must provide the name, zip code, parking type, website and phone number of the apartment complex."
    assert_command_output expected, command
  end

  def test_error_message_missing_zip
    command = "./apt_hunter create complex --name 'garden terrace'"
    expected = "You must provide the zip code, parking type, website and phone number of the apartment complex."
    assert_command_output expected, command
  end

  def test_error_message_missing_parking
    command = "./apt_hunter create complex --name 'garden terrace' --zip 37075"
    expected = "You must provide the parking type, website and phone number of the apartment complex."
    assert_command_output expected, command
  end

  def test_error_message_missing_website
    command = "./apt_hunter create complex --name 'garden terrace' --zip 37075 --parking covered"
    expected = "You must provide the website and phone number of the apartment complex."
    assert_command_output expected, command
  end

  def test_error_message_missing_phone_number
    command = "./apt_hunter create complex --name 'garden terrace' --zip 37075 --parking covered --website 'www.gardenterrace.com'"
    expected = "You must provide the phone number of the apartment complex."
    assert_command_output expected, command
  end

  def test_valid_complex_saved
    execute_popen("./apt_hunter create complex --name 'Garden Terrace' --zip 37075 --parking garage --website 'www.gardenterrace.com' --phone '555-555-5555' --environment test")
    results = ApartmentComplex.all.first
    actual = [results.name, results.zip, results.parking, results.website, results.phone]
    expected = ["Garden Terrace", 37075, "garage", "www.gardenterrace.com", "555-555-5555"]
    assert_equal expected, actual

    result = ApartmentComplex.count
    assert_equal 1, result
  end

  def test_invalid_complex_not_saved
    `./apt_hunter create complex --name 'Garden Terrace' --environment test`
    result = ApartmentComplex.count
    assert_equal 0, result
  end

end