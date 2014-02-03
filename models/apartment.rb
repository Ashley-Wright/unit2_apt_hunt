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
    complex_id
  end

  # def self.view
  #   db = Environment.database_connection
  #   db.results_as_hash = true
  #   statement = "select apartments.*, complexes.* from apartments inner join complexes on apartments.complex_id = complexes.id order by complexes.name asc"
  #   results = db.execute(statement)
  #   results.map do |row_hash|
  #     apartment = Apartment.new(rent: row_hash["apartments.rent"], size: row_hash["apartments.size"], bedrooms: row_hash["apartments.bedrooms"], bathrooms: row_hash["apartments.bathrooms"], complex_id: row_hash["apartments.complex_id"])
  #     apartment.send("id=", row_hash["apartments.id"])
  #     apartment
  #   end
  # end

  # def self.view
  #   db = Environment.database_connection
  #   db.results_as_hash = true
  #   statement = "select apartments.* from apartments"
  #   results = db.execute(statement)
  #   results.map do |row_hash|
  #     apartment = Apartment.new(rent: row_hash["rent"], size: row_hash["size"], bedrooms: row_hash["bedrooms"], bathrooms: row_hash["bathrooms"], complex_id: row_hash["complex_id"])
  #     complex = Complex.get(row_hash["complex_id"])
  #     apartment.complex = complex
  #     apartment.send("id=", row_hash["id"])
  #     apartment
  #   end
  # end

  def self.view(min = nil, max = nil)
    db = Environment.database_connection
    db.results_as_hash = true
    if min || max
      statement = "select apartments.* from apartments where rent between #{min} and #{max}"
    else
      statement = "select apartments.* from apartments"
    end
    results = db.execute(statement)
    results.map do |row_hash|
      apartment = Apartment.new(rent: row_hash["rent"], size: row_hash["size"], bedrooms: row_hash["bedrooms"], bathrooms: row_hash["bathrooms"], complex_id: row_hash["complex_id"])
      apartment.send("id=", row_hash["id"])
      apartment
    end
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


  protected

  def id=(id)
    @id = id
  end

end

