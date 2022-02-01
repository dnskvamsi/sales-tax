require 'net/http'
require 'json'

class CoversionData

    attr_accessor :url

    def initialize(url)
        @url = url
    end

    def fetch_conversion_rates()
        print("please select the conversion INR,USD,EUR: ")
        convert_to = gets().chomp().strip().upcase
        # url = "http://data.fixer.io/api/latest?access_key=93cae40df10b0521f99e1271a38794b9&base=EUR&symbols=INR,USD,EUR"
        uri = URI(@url)
        response = Net::HTTP.get(uri)
        convert=JSON.parse(response)
        if(convert["success"]==false)
            convert["rates"]={"USD"=>1.12,"EUR"=>1,"INR"=>83.58}
        end
        return convert["rates"][convert_to]
    end

end