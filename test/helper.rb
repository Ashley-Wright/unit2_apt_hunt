require 'minitest/autorun'

class AptHuntTest < MiniTest::Unit::TestCase
  def database
    @database ||= SQLite3::Database.new("apt_hunter_test")
  end

  def teardown
    database.execute("delete from complexes")
  end

  def assert_command_output expected, command
    actual = `#{command}`.strip
    assert_equal expected, actual
  end
end