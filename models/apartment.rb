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

end

