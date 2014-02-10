class ApartmentComplex < ActiveRecord::Base
  default_scope{order("name ASC")}
end


# require_relative '../lib/environment'

# class ApartmentComplex
#   attr_accessor :name, :zip, :parking, :website, :phone
#   attr_reader :id

#   def initialize attributes = {}
#     attributes.each_pair do |attribute, value|
#       self.send("#{attribute}=", value)
#     end
#   end

#   def self.create attributes = {}
#     complex = ApartmentComplex.new(attributes)
#     complex.save
#     complex
#   end

#   def update attributes = {}
#     [:name, :zip, :parking, :website, :phone].each do |attr|
#       if attributes[attr]
#         self.send("#{attr}=", attributes[attr])
#       end
#     end
#     save
#   end

#   def self.get id
#     db = Environment.database_connection
#     db.results_as_hash = true
#     statement = "select * from apartmentcomplexes where id = #{id}"
#     row = db.get_first_row(statement)
#     if row
#       complex = ApartmentComplex.new(name: row["name"], zip: row["zip"], parking: row["parking"], website: row["website"], phone: row["phone"])
#       complex.send("id=", row["id"])
#       return complex
#     else
#       nil
#     end
#   end

#   def save
#     db = Environment.database_connection
#     if id
#       statement = "update apartmentcomplexes set name='#{name}', zip=#{zip}, parking='#{parking}', website='#{website}', phone='#{phone}' where id=#{id}"
#       db.execute(statement)
#     else
#       statement = "insert into apartmentcomplexes(name, zip, parking, website, phone) values('#{name}', #{zip}, '#{parking}', '#{website}', '#{phone}')"
#       db.execute(statement)
#       @id = db.last_insert_row_id
#     end
#   end

#   def self.view
#     db = Environment.database_connection
#     db.results_as_hash = true
#     statement = "select * from apartmentcomplexes order by name ASC"
#     results = db.execute(statement)
#     results.map do |row_hash|
#       complex = ApartmentComplex.new(name: row_hash["name"], zip: row_hash["zip"], parking: row_hash["parking"], website: row_hash["website"], phone: row_hash["phone"])
#       complex.send("id=", row_hash["id"])
#       complex
#     end
#   end

#   def self.count
#     db = Environment.database_connection
#     db.execute("select count(id) from apartmentcomplexes")[0][0]
#   end

#   def to_s
#     "#{name}   #{id}   #{zip}   #{parking}   #{website}   #{phone}"
#   end

#   def self.validate options
#     missing_arguments = []
#     missing_arguments << "name" unless options[:name]
#     missing_arguments << "zip code" unless options[:zip]
#     missing_arguments << "parking type" unless options[:parking]
#     missing_arguments << "website" unless options[:website]
#     missing_arguments << "phone number" unless options[:phone]

#     unless missing_arguments.empty?
#       if missing_arguments.length == 1
#         error = "You must provide the #{missing_arguments.last} of the apartment complex."
#       else
#         error = "You must provide the #{missing_arguments[0..-2].join(", ") + " and"} #{missing_arguments.last} of the apartment complex."
#       end
#       error
#     end
#   end


#   protected

#   def id=(id)
#     @id = id
#   end
# end
