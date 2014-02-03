require 'optparse'

class Parser
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
      opts.on("--rent [rent]", "rent") do |rent|
        options[:rent] = rent
      end
      opts.on("--size [size]", "size") do |size|
        options[:size] = size
      end
      opts.on("--bedrooms [bedrooms]", "bedrooms") do |bedrooms|
        options[:bedrooms] = bedrooms
      end
      opts.on("--bathrooms [bathrooms]", "bathrooms") do |bathrooms|
        options[:bathrooms] = bathrooms
      end
      opts.on("--complex [complex]", "complex") do |complex|
        options[:complex] = complex
      end
      opts.on("--min [min]", "min") do |min|
        options[:min] = min
      end
      opts.on("--max [max]", "max") do |max|
        options[:max] = max
      end
    end.parse!
    options
  end

end