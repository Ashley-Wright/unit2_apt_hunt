require 'minitest/autorun'

class AptHuntTest < MiniTest::Unit::TestCase
  def database
    @database ||= SQLite3::Database.new("db/apt_hunter.sqlite3")
  end

  def teardown
    database.execute("delete from complexes")
  end

  def assert_command_output expected, command
    actual = `#{command}`.strip
    assert_equal expected, actual
  end
end