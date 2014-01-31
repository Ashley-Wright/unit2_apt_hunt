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

  def update attributes = {}
    [:name, :zip, :parking, :website, :phone].each do |attr|
      if attributes[attr]
        self.send("#{attr}=", attributes[attr])
      end
    end
    save
  end

  def self.get id
    db = Environment.database_connection
    db.results_as_hash = true
    statement = "select * from complexes where id = #{id}"
    row = db.get_first_row(statement)
    if row
      complex = AptComplex.new(name: row["name"], zip: row["zip"], parking: row["parking"], website: row["website"], phone: row["phone"])
      complex.send("id=", row["id"])
      return complex
    else
      nil
    end
  end

  def save
    db = Environment.database_connection
    if id
      statement = "update complexes set name='#{name}', zip=#{zip}, parking='#{parking}', website='#{website}', phone='#{phone}' where id=#{id}"
      db.execute(statement)
    else
      statement = "insert into complexes(name, zip, parking, website, phone) values('#{name}', #{zip}, '#{parking}', '#{website}', '#{phone}')"
      db.execute(statement)
      @id = db.last_insert_row_id
    end
  end

  def self.view
    db = Environment.database_connection
    db.results_as_hash = true
    statement = "select * from complexes order by name ASC"
    results = db.execute(statement)
    results.map do |row_hash|
      complex = AptComplex.new(name: row_hash["name"], zip: row_hash["zip"], parking: row_hash["parking"], website: row_hash["website"], phone: row_hash["phone"])
      complex.send("id=", row_hash["id"])
      complex
    end
  end

  def to_s
    "#{name}   #{id}   #{zip}   #{parking}   #{website}   #{phone}"
  end


  protected

  def id=(id)
    @id = id
  end
end
