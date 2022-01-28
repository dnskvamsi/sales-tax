require_relative "Item"
require_relative "Tax"
require 'net/http'
require 'json'

def fetch_conversion_rates(convert_to)
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
        print("Enter Quantity in Integers: ")
        qty=gets().chomp().strip().to_i
        print("Enter Item Description: ")
        item_description = gets().chomp().strip()
        print("Enter Shelf Price of the Item: ")
        price= gets().chomp().strip().to_f
        add_item(Item.new(qty,item_description,price),items)
        print("To Exit press q: ")
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

def data_generator()
    items=get_items_from_the_user()
    print("please select the conversion INR,USD,EUR: ")
    convert_to = gets().chomp().strip()
    convert=fetch_conversion_rates(convert_to)
    total_tax=0
    total_price=0
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
    total_price,total_tax=total_calculator(items)
    data=[]
    data.push(["Qty","Item_description","Price","Item_tax"])
    for item in items
        item_data=[]
        item_data.push(item.qty,item.item_description)
        item_data.push((item.price*convert).round(2))
        item_data.push((item.item_tax*convert).round(2))
        data.push(item_data)
    end
    data.push(["total_price: #{(total_price*convert).round(2)}"],["total_tax: #{(total_tax*convert).round(2)}"])
    file=FileCreator.new(data,file_name,file_extension,delimiter[extension])
    file.write()
end



if $PROGRAM_NAME == __FILE__
    data_generator()
end