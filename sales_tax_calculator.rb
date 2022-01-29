require_relative "Item"
require_relative "Tax"
require_relative "FileCreate"
require 'net/http'
require 'json'

def get_input()
    return gets().chomp().strip()
end

def fetch_conversion_rates()
    print("please select the conversion INR,USD,EUR: ")
    convert_to = get_input()
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

def test_qty_from_user()
    print("Enter Quantity in Integers: ")
    begin
        qty=Integer(get_input())
        raise ArgumentError unless qty.positive?
    rescue => exception
        puts("**Please Enter a valid quantity of integer type**")
        qty=get_input().to_i
    ensure
        return qty
    end
end

def test_shelf_price_from_user()
    print("Enter Shelf Price of the Item: ")
    begin
        price= Float(get_input())
        raise ArgumentError unless price>=0
    rescue => exception
        puts("**Please enter a valid price: **")
        price= get_input().to_f
    ensure
        return price
    end
end

def test_item_desc_from_user()
    print("Enter Item Description: ")
    item_description = get_input()
    return item_description
end

def cont_or_quit()
    print("To Exit press q or press any other key to add more items: ")
    get_input().downcase()=="q"
end

def get_items_from_the_user()
    items=[]
    loop do   
        # Item Quantity Details
        qty=test_qty_from_user()

        #  Item Description Details
        item_description = test_item_desc_from_user()
       
        # Item Shelf Price Details
        price = test_shelf_price_from_user()

        ## Add Items to the items array
        add_item(Item.new(qty,item_description,price),items)

        ## To quit or re-enter (break out of the loop)
        break if cont_or_quit()

    end
    return items
end

def add_item(item,item_arr)
    item_arr.push(item)
end

def get_file_details()
    puts("Enter the extension to save the file(1,2): ")
    puts("1. Text\n2. CSV")
    extension=get_input()
    print("Enter the name of the file without extension: ")
    file_name=get_input()
    delimiter={"1"=>"|","2"=>","}
    if(extension=="1")
        file_extension=".txt"
    elsif(extension=="2") 
        file_extension =".csv"
    end
    return file_name,file_extension,delimiter[extension]
end

class Generate
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
        return data
    end
end

if $PROGRAM_NAME == __FILE__
   Generate.new().data_generator()
end