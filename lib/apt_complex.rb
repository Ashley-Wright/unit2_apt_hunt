require_relative 'environment'

class AptComplex
  def initialize (name, zip, parking, website, phone, environment)
    @db = Environment.database_connection(environment)
    @name = name
    @zip = zip
    @parking = parking
    @website = website
    @phone = phone
  end

  def create
    statement = "insert into complexes(name, zip, parking, website, phone) values('#{@name}', #{@zip}, '#{@parking}', '#{@website}', '#{@phone}')"
    @db.execute(statement)
  end

  def self.view (environment)
    statement = "select name, zip, parking, website, phone from complexes"
    db = Environment.database_connection(environment)
    results = db.execute(statement)
  end
end
