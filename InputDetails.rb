# require_relative "./InputDetailsValidation"

class InputDetails
    
    attr_accessor :items
    def get_input()
        return gets().chomp().strip()
    end

    def display_message(message)
        return message
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


    def get_qty_from_user(item)
        print(display_message("Enter Quantity in Integers: "))
        begin
            item.qty= get_input()
            item.qty=item.validate_qty()
        rescue => exception
            print(display_message("Check and RE-"))
            get_qty_from_user(item)
        end
    end

    def get_shelf_price_from_user(item)
        print(display_message("Enter Shelf Price of the Item: "))
        begin
            # shelf_price_test()
            item.price = get_input()
            item.price = item.validate_price()
        rescue => exception
            print(display_message("Check and RE-"))
            get_shelf_price_from_user(item)
        end
    end

    def get_item_desc_from_user(item)
        print(display_message("Enter Item Description: "))
        item.item_description = get_input()
        return item.item_description
    end

    def cont_or_quit?
        # print("To Exit press q or press any other key to add more items: ")
        print(display_message("To Exit press q or press any other key to add more items: "))
        get_input().downcase()=="q"
    end

    def get_items_from_the_user()
        @items=[]
        loop do 
            ## Create new object for every loop

            item= Item.new()  

            # Item Quantity Details
            qty=get_qty_from_user(item)

            #  Item Description Details
            item_description = get_item_desc_from_user(item)
        
            # Item Shelf Price Details
            price = get_shelf_price_from_user(item)

            ## Add Items to the items array
            # add_item(Item.new(qty,item_description,price),@items)
            item.calculated_details()
            add_item(item)

            ## To quit or re-enter (break out of the loop)
            break if cont_or_quit?

        end
        return @items
    end

    def add_item(item)
        @items.push(item)
    end

    def get_file_details()
        files_in_pwd=Dir.entries(Dir.pwd)
        files_in_pwd.keep_if {|filename| filename.end_with? "FileWriter.rb"}
        plugins = files_in_pwd.map{|filename| filename.gsub(/FileWriter.rb/,"").downcase}
        print(display_message("Enter one of the extensions given below\n"))
        print(display_message("#{plugins.join("\n")}\n"))
        # puts(plugins)
        plug=get_input().downcase
        print(display_message("Enter the name of the file without extension: "))
        file_name=get_input()

        if (plugins.find_index(plug))
            file_class_name = files_in_pwd[plugins.find_index(plug)].gsub(/.rb/,"")
        else
           file_class_name = "FileCreator"
        end

        return file_name,file_class_name
    end

end
