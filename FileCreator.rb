class FileCreator

    attr_accessor :data,:file_name

    def initialize(items,file_name)
        @items = items
        @file_name = file_name
    end

    def heading()
        headings=["Qty","Item_description","Price","Item_tax"]
        @fileobject.write("#{headings.join("|")}\n")
    end

    def write(convert,total_price,total_tax)
        @fileobject=File.open("#{@file_name}"+".txt","a")
        self.heading()
        for item in @items
             @fileobject.write("#{item.to_array(convert).join("|")}\n")
        end
        @fileobject.write("total_price: #{(total_price*convert).round(2)}\n")
        @fileobject.write("total_tax: #{(total_tax*convert).round(2)}\n")
        @fileobject.close()
        return File.expand_path(File.dirname(__FILE__))
    end
    
end