require_relative 'environment'

class AptComplex
  attr_accessor :name, :zip, :parking, :website, :phone

  def initialize attributes = {}
    attributes.each_pair do |attribute, value|
      self.send("#{attribute}=", value)
    end
  end

  def create (environment)
    statement = "insert into complexes(name, zip, parking, website, phone) values('#{name}', #{zip}, '#{parking}', '#{website}', '#{phone}')"
    db = Environment.database_connection(environment)
    db.execute(statement)
  end

  def self.view (environment)
    statement = "select name, zip, parking, website, phone from complexes"
    db = Environment.database_connection(environment)
    db.results_as_hash = true
    results = db.execute(statement)
    results.map do |row_hash|
      AptComplex.new(name: row_hash["name"], zip: row_hash["zip"], parking: row_hash["parking"], website: row_hash["website"], phone: row_hash["phone"])
    end
  end

  def to_s
    "#{name}:   #{zip}   #{parking}   #{website}   #{phone}"
  end
end
