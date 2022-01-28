require_relative "Item"
require_relative "Tax"
require 'net/http'
require 'json'

def fetch_conversion_rates()
    print("please select the conversion INR,USD,EUR: ")
    convert_to = gets().chomp().strip()
    url = "http://data.fixer.io/api/latest?access_key=93cae40df10b0521f99e1271a38794b9&base=EUR&symbols=INR,USD,EUR"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    convert=JSON.parse(response)
    if(convert["success"]==false)
        convert["rates"]={"USD"=>1.12,"EUR"=>1,"INR"=>83.58}
    end
    return convert["rates"][convert_to]
end

def total_calculator(items)
    total_price=0
    total_tax=0
    for item in items
        total_price += item.item_total
        total_tax += item.item_tax
    end
    return total_price,total_tax
end


def get_items_from_the_user()
    items=[]
    loop do   

        # Item Quantity Details

        print("Enter Quantity in Integers: ")
        begin
            qty=Integer(gets().chomp().strip())
        rescue => exception
            puts("**Please Enter a valid quantity of integer type**")
            qty=gets().chomp().strip().to_i
        end

        #  Item Description Details

        print("Enter Item Description: ")
        item_description = gets().chomp().strip()
       
        # Item Shelf Price Details

        print("Enter Shelf Price of the Item: ")
        begin
            price= Float(gets().chomp().strip())
        rescue => exception
            puts("**Please enter a valid price: **")
            price= gets().chomp().strip().to_f
        end

        ## Add Items to the items array

        add_item(Item.new(qty,item_description,price),items)

        ## To quit or re-enter (break out of the loop)

        print("To Exit press q or press any other key to add more items: ")
        add_or_quit=gets().chomp().strip().downcase()
        break if add_or_quit =="q"
        
    end
    return items
end

def add_item(item,item_arr)
    item_arr.push(item)
end


class FileCreator
    attr_accessor :data,:extension,:delimiter,:file_name
    def initialize(data,file_name,extension,delimiter)
        @data = data
        @extension = extension
        @delimiter = delimiter
        @file_name = file_name
    end
    def write()
        fileobject=File.open("#{@file_name}"+"#{@extension}","a")
        for row in @data
             fileobject.write("#{row.join(@delimiter)}\n")
        end
    end
end

def get_file_details()
    puts("Enter the extension to save the file: ")
    puts("1. Text\n2. CSV")
    extension=gets().chomp().strip()
    print("Enter the name of the file without extension: ")
    file_name=gets().chomp().strip()
    delimiter={"1"=>"|","2"=>","}
    if(extension=="1")
        file_extension=".txt"
    elsif(extension=="2") 
        file_extension =".csv"
    end
    return file_name,file_extension,delimiter[extension]
end


def data_generator()
    total_tax=0
    total_price=0

    ## Get Items 
    items = get_items_from_the_user()

    ## Fetch the conversion data from the flixer
    convert = fetch_conversion_rates()

    ## get the file details
    file_name,file_extension,delimiter = get_file_details()

    ## Calculate the tax
    total_price,total_tax=total_calculator(items)

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
    file=FileCreator.new(data,file_name,file_extension,delimiter)
    file.write()

end

if $PROGRAM_NAME == __FILE__
    data_generator()
end