require_relative '../lib/environment'

class Apartment
  attr_accessor :rent, :size, :bedrooms, :bathrooms
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
    statement = "insert into apartments(rent, size, bedrooms, bathrooms) values(#{rent}, #{size}, #{bedrooms}, #{bathrooms})"
    db.execute(statement)
    @id = db.last_insert_row_id
  end

end

