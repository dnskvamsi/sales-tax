require_relative "Item"
require_relative "Tax"
require_relative "FileCreator"
require 'net/http'
require 'json'
require_relative './InputDetails'
# require_relative 'TxtFileWriter'
require_relative "Conversion"
Dir["#{Dir.pwd}"+"/*FileWriter.rb"].each {|file| require file }

# Dir["#{Dir.pwd}"+"/plugins"+"/*FileWriter.rb"].each {|file| require file }

class Generate

    def initialize(input=InputDetails.new(),conversion_data=CoversionData(url))
        @item_details = input
        @conversion_data = conversion_data
    end
    
    def data_generator()
        total_tax=0
        total_price=0

        ## Get Items 
        items = @item_details.get_items_from_the_user()
        ## Fetch the conversion data from the flixer
        # convert = @item_details.fetch_conversion_rates()
        convert = @conversion_data.fetch_conversion_rates()

        ## get the file details
        file_name,file_class = @item_details.get_file_details()

        ## Calculate the tax
        total_price,total_tax = @item_details.total_calculator(items)

        data=[]
        data.push(["Qty","Item_description","Price","Item_tax"])

        for item in items
            data.push(item.to_array(convert))
        end
        data.push(["total_price: #{(total_price*convert).round(2)}"],["total_tax: #{(total_tax*convert).round(2)}"])

        ## File object creation and writing the data into the file
        file = Object.const_get(file_class).new(items,file_name)
        file.write(convert,total_price,total_tax)
        return data
    end
end