require 'minitest/autorun'
require_relative '../lib/environment'

class AptHuntTest < MiniTest::Unit::TestCase
  def setup
    Environment.environment = "test"
  end

  def database
    Environment.database_connection
  end

  def teardown
    database.execute("delete from apartmentcomplexes")
    database.execute("delete from apartments")
  end

  def assert_command_output expected, command
    actual = `#{command} --environment test`.strip
    assert_equal expected, actual
  end
end