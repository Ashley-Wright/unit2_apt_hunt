require_relative 'environment'

# class Table
#   database = Environment.database_connection(options[:environment])
#   @db = Environment.database_connection('test')
# end

class AptComplex
  def initialize (name, zip, parking, website, phone)
    @db = Environment.database_connection('test')
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

end
