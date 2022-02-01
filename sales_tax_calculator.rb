require_relative "Item"
require_relative "Tax"
require_relative "FileCreate"
require 'net/http'
require 'json'
require_relative 'InputDetails'
# require_relative 'TxtFileWriter'
Dir["#{Dir.pwd}"+"/*FileWriter.rb"].each {|file| require file }

# Dir["#{Dir.pwd}"+"/plugins"+"/*FileWriter.rb"].each {|file| require file }

class Generate

    def initialize(input=InputDetails.new())
        @item_details=input
    end
    
    def data_generator()
        total_tax=0
        total_price=0

        ## Get Items 
        items = @item_details.get_items_from_the_user()

        ## Fetch the conversion data from the flixer
        convert = @item_details.fetch_conversion_rates()

        ## get the file details
        file_name,file_class = @item_details.get_file_details()

        ## Calculate the tax
        total_price,total_tax = @item_details.total_calculator(items)

        data=[]
        data.push(["Qty","Item_description","Price","Item_tax"])

        for item in items
            item_data=[]
            item_data.push(item.qty)
            item_data.push(item.item_description)
            item_data.push((item.price*convert).round(2))
            item_data.push((item.item_tax*convert).round(2))
            data.push(item_data)
        end
        data.push(["total_price: #{(total_price*convert).round(2)}"],["total_tax: #{(total_tax*convert).round(2)}"])

        ## File object creation and writing the data into the file
        file=Object.const_get(file_class).new(data,file_name)
        file.write()
        return data
    end
end

if $PROGRAM_NAME == __FILE__
    input=InputDetails.new()
    Generate.new(input).data_generator()
end