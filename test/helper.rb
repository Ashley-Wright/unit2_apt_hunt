require 'minitest/autorun'
require_relative '../lib/environment'

class AptHuntTest < MiniTest::Unit::TestCase
  def setup
    Environment.environment = "test"
    Environment.connect_to_database
  end

  def teardown
    ApartmentComplex.destroy_all
    Apartment.destroy_all
  end

  def assert_command_output expected, command
    actual = `#{command} --environment test`.strip
    assert_equal expected, actual
  end
end