# require_relative "../Tax"
require_relative "../Item"


RSpec.describe "Item class" do

    context "When testing the Item Class with valid arguments" do
       
        it "should return product of qty and price when we call item-price" do
            item=Item.new(2,"books",29.99)
            item.calculated_details()
            expect(item.item_price).to eq(59.98)
        end
        
        it "should return total price of the item as 0 if price is zero" do
            item=Item.new(2,"books",0)
            item.calculated_details()
            expect(item.item_total).to eq(0)
        end
        it "should return total price of the item including the tax when you call item_total" do
            item=Item.new(2,"books",29.99)
            item.calculated_details()
            expect(item.item_total).to eq(59.98)
        end
    end

    context "When passing Invalid arguments to qty" do
        it "should raise a error when you provide invalid input string to the qty and call validate_item" do
            item=Item.new("a","books",29.99)
            expect{item.validate_item()}.to raise_error(ArgumentError)
        end
        it "should raise a error when you provide -ve value to the qty and call validate_item" do
            item= Item.new(-2,"books",29.99)
            expect{item.validate_item()}.to raise_error(ArgumentError)
        end
        it "should raise a error when you provide 0 value to the qty" do
            item = Item.new(0,"books",29.99)
            expect{item.validate_item()}.to raise_error(ArgumentError)
        end

        it "should raise a error when you provide -ve value to the price" do
            item = Item.new(-2.2,"books",29.99)
            expect{item.validate_item()}.to raise_error(ArgumentError)
        end

        it "should raise a error when you provide -ve value to the price" do
            item= Item.new(2.2,"books",29.99)
            expect{item.validate_item()}.to raise_error(ArgumentError)
        end
    end

    context "When passing Invalid arguments to price and validate_price" do
        it "should raise a error when you provide invalid input string to the price" do
            expect{Item.new(1,"books","a").validate_price()}.to raise_error(ArgumentError)
        end
        it "should raise a error when you provide invalid input string to the price" do
            expect{Item.new(1,"books",-29.99).validate_price()}.to raise_error(ArgumentError)
        end
        it "should raise a error when you provide -ve value to the price" do
            expect{Item.new(1,"books","ab").validate_price()}.to raise_error(ArgumentError)
        end
        it "should raise a error when you provide -0.1 value to the qty" do
            expect{Item.new(1,"books",-0.1).validate_price()}.to raise_error(ArgumentError)
        end
    end

    context "When testing the imported?" do

        it "should say 'imported' if the item_desc contains imported word(valid)" do
            item = Item.new(2,"books imported",30.02)
            expect(item.imported?).to be_truthy
        end

        it "should say 'not imported' if the item_desc does not contain imported word" do
            item = Item.new(2,"books",30.02)
            expect(item.imported?).to be_falsy
        end
    end

    context "When testing the exempted?" do
        it "should say 'exempted' if the item is in any of the book,food,medical products" do
            item=Item.new(2,"books imported",39.99)
            expect(item.exempted?).to be_truthy
        end
        it "should say 'not exempted' if the item is not in any of the book,food,medical products" do
            item=Item.new(2,"shelf imported",39.99)
            expect(item.exempted?).to be_falsy
        end
    end

    context "When passing combinations of imported and exempted items to the calculate()" do

        it "should calculate tax to 15% if the item is not exempted and imported" do
            item=Item.new(1,"imported box of perfume",27.99)
            item.calculated_details()
            expect(item.calculate_item_tax()).to eq(4.2)
        end

        it "should calculate tax to 10% if the item is not exempted and not imported" do
            item=Item.new(1,"bottle of perfume",27.99)
            item.calculated_details()
            expect(item.calculate_item_tax()).to eq(2.8)
        end
        
        it "should calculate tax to 5% if the item is imported and not exempted" do
            item=Item.new(1,"books imported",30.99)
            item.calculated_details()
            expect(item.calculate_item_tax()).to eq(1.55)
        end
    end

    context "When passing price=0 to the calculate()" do

        it "should return 0 if price is zero" do
            item=Item.new(2,"books imported",0)
            item.calculated_details()
            expect(item.calculate_item_tax()).to eq(0)
        end

    end
end