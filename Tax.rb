class Tax
    
    attr_accessor :item_desc,:price

    FOOD_ITEMS = ["chocolate", "waffles", "cakes", "chips", "soft drink"]
    MEDICAL_ITEMS = ["tablets", "capsules", "syrup"]
    BOOK_ITEMS = ["book"]
    EXEMPTED_ITEMS = FOOD_ITEMS + MEDICAL_ITEMS + BOOK_ITEMS
    
    def initialize(item_desc, price)
        @item_desc = item_desc
        @price = price
    end

    def imported?
        return @item_desc.downcase.include? "imported"
    end

    def exempted?
        EXEMPTED_ITEMS.any? {|item| @item_desc.downcase.include? item}
    end

    def calculate()
        if !(@price.is_a? Numeric and @price>=0)
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
