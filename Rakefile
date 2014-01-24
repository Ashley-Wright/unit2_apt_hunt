#!/usr/bin/env ruby

require_relative 'lib/environment'
require 'rake/testtask'
Rake::TestTask.new() do |t|
  t.pattern = "test/test_*.rb"
end

desc "Run tests"
task :default => :test

task :bootstrap_database do
  require 'sqlite3'
  database = Environment.database_connection("production")
  database.execute("CREATE TABLE complexes (id INTEGER PRIMARY KEY AUTOINCREMENT, name varchar(50), zip integer, parking varchar(15), website varchar(50), phone varchar(14))")
end

task :test_prepare do
  require 'sqlite3'
  File.delete("db/apt_hunter.sqlite3")
  database = Environment.database_connection("test")
  database.execute("CREATE TABLE complexes (id INTEGER PRIMARY KEY AUTOINCREMENT, name varchar(50), zip integer, parking varchar(15), website varchar(50), phone varchar(14))")
end