require_relative "Item"
require_relative "Tax"
require 'net/http'
require 'json'

def fetch_conversion_rates()
    url = "http://data.fixer.io/api/latest?access_key=93cae40df10b0521f99e1271a38794b9&base=EUR&symbols=INR,USD,EUR"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    convert=JSON.parse(response)
    if(convert["success"]==false)
        convert["rates"]={"USD"=>1.12,"EUR"=>1,"INR"=>83.58}
    end
    return convert
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

def write_to_file(items)
    print("please select the conversion INR,USD,EUR: ")
    convert_to = gets().chomp().strip()
    convert=fetch_conversion_rates()
    total_tax=0
    total_price=0
    puts("Enter the extension to save the file: ")
    puts("1. Text\n2. CSV")
    extension=gets().chomp().strip()
    delimiter={"1"=>"|","2"=>","}
    if(extension=="1")
        file_extension=".txt"
    elsif(extension=="2") 
    file_extension =".csv"
    end
   fileobject= File.open("tax"+"#{file_extension}","a")
   fileobject.write("Qty\
        #{delimiter[extension]} Item_description\
        #{delimiter[extension]} Price\
        #{delimiter[extension]} Item_tax\n")
    for item in items
        total_tax += item.item_tax
        total_price += item.item_total
        if convert_to == "INR" || convert_to == "USD" || convert_to=="EUR"
            fileobject.write("#{item.qty} \
    #{delimiter[extension]} #{item.item_description} \
    #{delimiter[extension]} #{(item.price*convert["rates"][convert_to]).round(2)} \
    #{delimiter[extension]} #{(item.item_tax*convert["rates"][convert_to]).round(2)}\n")
        end
    end
    fileobject.write("Total-tax: #{(total_tax*convert["rates"][convert_to]).round(2)}\nTotal_price: #{(total_price*convert["rates"][convert_to]).round(2)}\n")
    
end


write_to_file(get_items_from_the_user())