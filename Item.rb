# require_relative "./Tax"


class Item

    attr_accessor :qty,:item_description,:price,:item_price,:tax,:item_tax,:item_total

    FOOD_ITEMS = ["chocolate", "waffles", "cakes", "chips", "soft drink"]
    MEDICAL_ITEMS = ["tablets", "capsules", "syrup"]
    BOOK_ITEMS = ["book"]
    EXEMPTED_ITEMS = FOOD_ITEMS + MEDICAL_ITEMS + BOOK_ITEMS
    IMPORTED_TAX_RATE = 0.05    ## 5% on imported items
    NON_EXEMPTED_ITEMS_TAX_RATE = 0.1  ## 10% on non-exempted items
    ROUND_OFF_TO = 0.05        ## To nearest 0.05

    def initialize(qty=nil, item_description=nil, price=nil)
        @qty = qty
        @item_description = item_description
        @price = price
    end

    def calculated_details()
            @item_price = @qty * @price
            @item_tax = self.calculate_item_tax()
            @item_total = @item_tax + @item_price
    end

    def to_array(convert)
        item_details=[]
        item_details.push(@qty)
        item_details.push(@item_description)
        item_details.push((@price*convert).round(2))
        item_details.push((@item_tax*convert).round(2))
        return item_details
    end

    def validate_item()
        raise ArgumentError unless (@qty.is_a? Integer and @price.is_a? Numeric)
        raise ArgumentError unless (@qty.positive? and @price>=0)
    end

    def validate_qty()
        (raise ArgumentError unless Integer(qty).positive?) or Integer(qty)
    end

    def validate_price()
        (raise ArgumentError unless Float(price)>=0) or Float(price)
    end

    def imported?
        return @item_description.downcase.include? "imported"
    end

    def exempted?
        EXEMPTED_ITEMS.any? { |item| @item_description.downcase.include? item }
    end

    def calculate_item_tax()
        if !(@price.is_a? Numeric and @price>=0)
            raise ArgumentError  
            # raise ArgumentError unless (@price.is_a? Numeric and @price>=0)
        end

        @tax = 0
        if imported?
            @tax = @tax + @item_price * IMPORTED_TAX_RATE
        end

        # @tax = @tax + @price * 0.05 if imported?

        if !(exempted?)
            @tax = @tax + @item_price * NON_EXEMPTED_ITEMS_TAX_RATE
        end

        # @tax = @tax + @price*0.1 unless exempted?

        return ((@tax / ROUND_OFF_TO).round() * ROUND_OFF_TO).round(2)
    end

end
