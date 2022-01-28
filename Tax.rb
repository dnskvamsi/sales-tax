class Tax
    attr_accessor :item_desc,:price

    @@food_items = ["chocolate", "waffles", "cakes", "chips", "soft drink"]
    @@medical_items = ["tablets", "capsules", "syrup"]
    @@book_items = ["book"]
    @@exempted_items = @@food_items + @@medical_items + @@book_items
    
    def initialize(item_desc, price)
        @item_desc = item_desc
        @price = price
    end

    def imported?
        return @item_desc.downcase.include? "imported"
    end

    def exempted?
        @@exempted_items.any? {|item| @item_desc.downcase.include? item}
    end

    def calculate()
        if !(@price.is_a? Numeric)
            raise ArgumentError
        end
        @tax = 0
        if imported?
            @tax = @tax + @price * 0.05
        end
        if !(exempted?)
            @tax = @tax + @price * 0.1
        end
        return ((@tax / 0.05).round() * 0.05).round(2)
    end
end
