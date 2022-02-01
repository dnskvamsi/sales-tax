require_relative "Tax"


class Item

    attr_accessor :qty,:item_description,:price,:item_price,:tax,:item_tax,:item_total

    def initialize(qty, item_description, price)
        raise ArgumentError unless (qty.is_a? Integer and price.is_a? Numeric)
        raise ArgumentError unless (qty.positive? and price>=0)
        @qty = qty
        @item_description = item_description
        @price = price
        @item_price = @qty * @price
        @tax = Tax.new(@item_description, @item_price)
        @item_tax = @tax.calculate()
        @item_total = @item_tax + @item_price
    end

end