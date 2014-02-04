require_relative '../lib/environment'

class Apartment
  attr_accessor :rent, :size, :bedrooms, :bathrooms, :complex_id, :price_per_sqft
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

  def update attributes = {}
    [:rent, :size, :bedrooms, :bathrooms, :complex_id].each do |attr|
      if attributes[attr]
        self.send("#{attr}=", attributes[attr])
      end
    end
    save
  end

  def save
    db = Environment.database_connection
    statement = "insert into apartments(rent, size, bedrooms, bathrooms, complex_id) values(#{rent}, #{size}, #{bedrooms}, #{bathrooms}, #{complex_id})"
    db.execute(statement)
    @id = db.last_insert_row_id
  end

  def self.get id
    db = Environment.database_connection
    db.results_as_hash = true
    statement = "select * from apartments where id = #{id}"
    row = db.get_first_row(statement)
    if row
      apartment = Apartment.new(rent: row["rent"], size: row["size"], bedrooms: row["bedrooms"], bathrooms: row["bathrooms"], complex_id: row["complex_id"])
      apartment.send("id=", row["id"])
      apartment
    else
      nil
    end
  end

  def self.get_complex_id complex_name
    db = Environment.database_connection
    statement = "select id from complexes where name= '#{complex_name}'"
    complex_id = db.execute(statement)
    complex_id
  end

  def self.view
    db = Environment.database_connection
    db.results_as_hash = true
    sort_by = 'complexes.name'
    statement = "select apartments.id, apartments.rent, apartments.size, apartments.bedrooms, apartments.bathrooms, apartments.complex_id, complexes.name from apartments inner join complexes on apartments.complex_id = complexes.id order by #{sort_by}"

    results = db.execute(statement)
    results.map do |row_hash|
      price_per = row_hash["rent"] / row_hash["size"]
      apartment = Apartment.new(rent: row_hash["rent"], size: row_hash["size"], bedrooms: row_hash["bedrooms"], bathrooms: row_hash["bathrooms"], price_per_sqft: price_per, complex_id: row_hash["complex_id"])
      apartment.send("id=", row_hash["id"])
      apartment
    end
  end

  def self.filter(min, max, sort = nil)
    db = Environment.database_connection
    db.results_as_hash = true

    if sort
      sort_by = sort + ' desc'
    else
      sort_by = 'complexes.name'
    end

    statement = "select apartments.id, apartments.rent, apartments.size, apartments.bedrooms, apartments.bathrooms, apartments.complex_id, complexes.name from apartments inner join complexes on apartments.complex_id = complexes.id where rent between #{min} and #{max} order by #{sort_by}"

    results = db.execute(statement)
    results.map do |row_hash|
      price_per = row_hash["rent"] / row_hash["size"]
      apartment = Apartment.new(rent: row_hash["rent"], size: row_hash["size"], bedrooms: row_hash["bedrooms"], bathrooms: row_hash["bathrooms"], price_per_sqft: price_per, complex_id: row_hash["complex_id"])
      apartment.send("id=", row_hash["id"])
      apartment
    end
  end

  def to_s
    db = Environment.database_connection
    statement = "select name from complexes where id= '#{complex_id}'"
    complex_name = db.execute(statement)
    if price_per_sqft
      price_per = sprintf "%.3f", price_per_sqft
      "#{id}   $#{rent}   #{size}   #{price_per}   #{bedrooms}   #{bathrooms}   #{complex_name[0][0]}"
    else
      "$#{rent}   #{size}   #{bedrooms}   #{bathrooms}   #{complex_name[0][0]}"
    end
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

