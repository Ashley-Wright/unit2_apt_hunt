require 'optparse'

class ComplexParser
  def self.parse
    options = {environment: "production"}
    OptionParser.new do |opts|
      opts.banner = "Usage: apt_hunter [command] [options]"

      opts.on("--name [NAME]", "name") do |name|
        options[:name] = name
      end
      opts.on("--zip [ZIP]", "zip code") do |zip|
        options[:zip] = zip
      end
      opts.on("--parking [parking]", "parking") do |parking|
        options[:parking] = parking
      end
      opts.on("--website [website]", "website") do |website|
        options[:website] = website
      end
      opts.on("--phone [phone]", "phone") do |phone|
        options[:phone] = phone
      end
      opts.on("--environment [env]", "environment") do |env|
        options[:environment] = env
      end
      opts.on("--id [id]", "id") do |id|
        options[:id] = id
      end
      opts.on("--key [key]", "key") do |key|
        options[:key] = key
      end
      opts.on("--value [value]", "value") do |value|
        options[:value] = value
      end
    end.parse!
    options
  end

  def self.validate options
    missing_arguments = []
    missing_arguments << "name" unless options[:name]
    missing_arguments << "zip code" unless options[:zip]
    missing_arguments << "parking type" unless options[:parking]
    missing_arguments << "website" unless options[:website]
    missing_arguments << "phone number" unless options[:phone]

    unless missing_arguments.empty?
      if missing_arguments.length == 1
        error = "You must provide the #{missing_arguments.last} of the apartment complex."
      else
        error = "You must provide the #{missing_arguments[0..-2].join(", ") + " and"} #{missing_arguments.last} of the apartment complex."
      end
      error
    end
  end
end