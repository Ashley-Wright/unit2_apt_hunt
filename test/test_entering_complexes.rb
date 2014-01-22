require_relative 'helper'

class TestEnteringComplexes < MiniTest::Unit::TestCase
  def test_error_message_missing_name
    command = "./apt_hunter add complex"
    expected = "You must provide the name of the apartment complex"
    assert_command_output expected, command
  end

  def test_error_message_missing_zip
    skip
    command = "./apt_hunter add complex --name 'garden terrace'"
    expected = "You must provide the zip code of the apartment complex"
    assert_command_output expected, command
  end

  def test_error_message_missing_parking
    skip
    command = "./apt_hunter add complex --name 'garden terrace' --zip 37075"
    expected = "You must provide the parking type of the apartment complex"
    assert_command_output expected, command
  end

  def test_error_message_missing_website
    skip
    command = "./apt_hunter add complex --name 'garden terrace' --zip 37075 --parking covered"
    expected = "You must provide the website of the apartment complex"
    assert_command_output expected, command
  end

  def test_error_message_missing_phone_number
    skip
    command = "./apt_hunter add complex --name 'garden terrace' --zip 37075 --parking covered --website 'www.gardenterrace.com'"
    expected = "You must provide the zip code of the apartment complex"
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