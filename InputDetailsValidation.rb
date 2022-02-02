class InputDetailsTesting

    def qty_test(qty)
        (raise ArgumentError unless Integer(qty).positive?) or Integer(qty)
    end

    def price_test(price)
        (raise ArgumentError unless Float(price)>=0) or Float(price)
    end

end