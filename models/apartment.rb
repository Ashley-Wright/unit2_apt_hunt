require_relative '../lib/environment'

class Apartment
  attr_accessor :rent, :size, :bedrooms, :bathrooms, :complex_id
  attr_reader :id

  def initialize attributes = {}
    attributes.each_pair do |attribute, value|
      self.send("#{attribute}=", value)
    end
  end

  def self.create attributes = {}
    apartment = Apartment.new(attributes)
    apartment.save
    apartment
  end

  def save
    db = Environment.database_connection
    statement = "insert into apartments(rent, size, bedrooms, bathrooms, complex_id) values(#{rent}, #{size}, #{bedrooms}, #{bathrooms}, #{complex_id})"
    db.execute(statement)
    @id = db.last_insert_row_id
  end

  def self.get_complex_id complex_name
    db = Environment.database_connection
    statement = "select id from complexes where name= '#{complex_name}'"
    complex_id = db.execute(statement)
    complex_id[0][0]
  end

  def to_s
    db = Environment.database_connection
    statement = "select name from complexes where id= '#{complex_id}'"
    complex_name = db.execute(statement)
    "$#{rent}   #{size}   #{bedrooms}   #{bathrooms}   #{complex_name[0][0]}"
  end

  def self.validate options
    missing_arguments = []
    missing_arguments << "rent" unless options[:rent]
    missing_arguments << "size" unless options[:size]
    missing_arguments << "number of bedrooms" unless options[:bedrooms]
    missing_arguments << "number of bathrooms" unless options[:bathrooms]
    missing_arguments << "name of apartment complex" unless options[:complex]

    unless missing_arguments.empty?
      if missing_arguments.length == 1
        error = "You must provide the #{missing_arguments.last}."
      else
        error = "You must provide the #{missing_arguments[0..-2].join(", ") + " and"} #{missing_arguments.last}."
      end
      error
    end
  end

end

