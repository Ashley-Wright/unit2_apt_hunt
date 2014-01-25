#!/usr/bin/env ruby

require_relative 'lib/environment'
require 'rake/testtask'
Rake::TestTask.new() do |t|
  t.pattern = "test/test_*.rb"
end

desc "Run tests"
task :default => :test

task :bootstrap_database do
  database = Environment.database_connection("production")
  create_tables(database)
end

task :test_prepare do
  File.delete("db/apt_hunter.sqlite3")
  database = Environment.database_connection("test")
  create_tables(database)
end

def create_tables(database_connection)
  database_connection.execute("CREATE TABLE complexes (id INTEGER PRIMARY KEY AUTOINCREMENT, name varchar(50), zip integer, parking varchar(15), website varchar(50), phone varchar(14))")
end