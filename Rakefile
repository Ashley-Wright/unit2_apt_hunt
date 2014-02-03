#!/usr/bin/env ruby

require_relative 'lib/environment'
require 'rake/testtask'
Rake::TestTask.new() do |t|
  t.pattern = "test/test_*.rb"
end

desc "Run tests"
task :default => :test

task :bootstrap_database do
  Environment.environment = "production"
  database = Environment.database_connection
  create_tables(database)
end

task :test_prepare do
  File.delete("db/apt_hunter_test.sqlite3")
  Environment.environment = "test"
  database = Environment.database_connection
  create_tables(database)
end

def create_tables(database_connection)
  database_connection.execute("CREATE TABLE complexes (id INTEGER PRIMARY KEY AUTOINCREMENT, name varchar(50), zip integer, parking varchar(15), website varchar(50), phone varchar(14))")
  database_connection.execute("CREATE TABLE apartments (id INTEGER PRIMARY KEY AUTOINCREMENT, rent decimal(7,2), size integer, bedrooms integer, bathrooms decimal(2,2), complex_id integer)")
end