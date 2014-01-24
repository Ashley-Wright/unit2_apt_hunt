require_relative 'helper'

class TestEnteringComplexes < MiniTest::Unit::TestCase
  def test_error_message_missing_name
    command = "./apt_hunter add complex"
    expected = "You must provide the name, zip code, parking type, website and phone number of the apartment complex."
    assert_command_output expected, command
  end

  def test_error_message_missing_zip
    command = "./apt_hunter add complex --name 'garden terrace'"
    expected = "You must provide the zip code, parking type, website and phone number of the apartment complex."
    assert_command_output expected, command
  end

  def test_error_message_missing_parking
    command = "./apt_hunter add complex --name 'garden terrace' --zip 37075"
    expected = "You must provide the parking type, website and phone number of the apartment complex."
    assert_command_output expected, command
  end

  def test_error_message_missing_website
    command = "./apt_hunter add complex --name 'garden terrace' --zip 37075 --parking covered"
    expected = "You must provide the website and phone number of the apartment complex."
    assert_command_output expected, command
  end

  def test_error_message_missing_phone_number
    command = "./apt_hunter add complex --name 'garden terrace' --zip 37075 --parking covered --website 'www.gardenterrace.com'"
    expected = "You must provide the phone number of the apartment complex."
    assert_command_output expected, command
  end

  def test_valid_complex_saved
    skip
    assert false, "Missing test implementation"
  end

  def test_invalid_complex_not_saved
    skip
    assert false, "Missing test implementation"
  end
end