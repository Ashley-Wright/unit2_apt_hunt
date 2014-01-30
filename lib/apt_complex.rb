require_relative 'environment'

class AptComplex
  attr_accessor :name, :zip, :parking, :website, :phone
  attr_reader :id

  def initialize attributes = {}
    attributes.each_pair do |attribute, value|
      self.send("#{attribute}=", value)
    end
  end

  def self.create attributes = {}
    complex = AptComplex.new(attributes)
    complex.save
    complex
  end

  def update (environment)
    statement = "update complexes set name='#{name}', zip=#{zip}, parking='#{parking}', website='#{website}', phone='#{phone}' where id=#{id}"
    db = Environment.database_connection(environment)
    db.execute(statement)
  end

  def self.get environment, id
    statement = "select id, name, zip, parking, website, phone from complexes where id = #{id}"
    db = Environment.database_connection(environment)
    row = db.get_first_row(statement)
    complex = AptComplex.new
    complex.id = row[0]
    complex.name = row[1]
    complex.zip = row[2]
    complex.parking = row[3]
    complex.website = row[4]
    complex.phone = row[5]
    return complex
  end

  def save
    db = Environment.database_connection
    statement = "insert into complexes(name, zip, parking, website, phone) values('#{name}', #{zip}, '#{parking}', '#{website}', '#{phone}')"
    db.execute(statement)
    @id = db.last_insert_row_id
  end

  def self.view (environment)
    statement = "select name, zip, parking, website, phone from complexes"
    db = Environment.database_connection(environment)
    db.results_as_hash = true
    results = db.execute(statement)
    results.map do |row_hash|
      complex = AptComplex.new(name: row_hash["name"], zip: row_hash["zip"], parking: row_hash["parking"], website: row_hash["website"], phone: row_hash["phone"])
      complex.send("id=", row_hash["id"])
      complex
    end
  end

  def to_s
    "#{name}:   #{zip}   #{parking}   #{website}   #{phone}, id: #{id}"
  end


  protected

  def id=(id)
    @id = id
  end
end
