require_relative "Item"
require_relative "Tax"
require 'net/http'
require 'json'

url = "http://data.fixer.io/api/latest?access_key=93cae40df10b0521f99e1271a38794b9&base=EUR&symbols=INR,USD"
uri = URI(url)
response = Net::HTTP.get(uri)
convert=JSON.parse(response)
items=[]
total_tax=0
total_price=0
loop do   
    print("Enter Quantity in Integers: ")
    qty=gets().chomp().strip().to_i
    print("Enter Item Description: ")
    item_description = gets().chomp().strip()
    print("Enter Shelf Price of the Item: ")
    price= gets().chomp().strip().to_f
    items.push(Item.new(qty,item_description,price))
    print("To Exit press q: ")
    add_or_quit=gets().chomp().strip().downcase()
    break if add_or_quit =="q"
end
print("please select the conversion INR,USD: ")
convert_to = gets().chomp().strip()
puts(convert_to)
puts(convert["rates"][convert_to])
for item in items
    total_tax += item.item_tax
    total_price += item.item_total
    if convert_to == "INR" || convert_to == "USD"
        puts("qty: #{item.qty*convert["rates"][convert_to]} \
| item_description: #{item.item_description} \
| price: #{item.price*convert["rates"][convert_to]} \
| item_tax: #{item.item_tax*convert["rates"][convert_to]}")
        # puts(item.item_tax)
        # puts(item.item_total)
        else
            puts("qty: #{item.qty}\
                | item_description: #{item.item_description} | price: #{item.price} | item_tax: #{item.item_tax}")
    end
end
puts("Enter the extension to save the file: ")
puts("1. Text\n2.CSV")
extension=gets().chomp().strip()
delimiter={"1"=>"|","2"=>","}
for item in items
    total_tax += item.item_tax
    total_price += item.item_total
    if convert_to == "INR" || convert_to == "USD"
        File.open("tax.csv","a"){|f| f.write("qty: #{item.qty*convert["rates"][convert_to]} \
#{delimiter[extension]} item_description: #{item.item_description} \
#{delimiter[extension]} price: #{item.price*convert["rates"][convert_to]} \
#{delimiter[extension]} item_tax: #{item.item_tax*convert["rates"][convert_to]}\n")}
        else
            File.open("tax.csv","a"){|f| f.write("qty: #{item.qty}\
                #{delimiter[extension]} item_description: #{item.item_description}\
                #{delimiter[extension]} price: #{item.price}\
                #{delimiter[extension]} item_tax: #{item.item_tax}\n")}
    end
end
File.open("tax.csv","a"){|file| file.write("Total-tax: #{total_tax}\nTotal_price #{total_price.round(2)}\n")}


def get_items()
    items=[]
    loop do   
        print("Enter Quantity in Integers: ")
        qty=gets().chomp().strip().to_i
        print("Enter Item Description: ")
        item_description = gets().chomp().strip()
        print("Enter Shelf Price of the Item: ")
        price= gets().chomp().strip().to_f
        items.push(Item.new(qty,item_description,price))
        print("To Exit press q: ")
        add_or_quit=gets().chomp().strip().downcase()
        break if add_or_quit =="q"
    end
    return items
end