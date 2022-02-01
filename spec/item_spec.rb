require_relative "../Tax"
require_relative "../Item"


RSpec.describe "Item" do

    context "When testing the Item Class with valid arguments" do
        it "should be a instance of tax object when we call tax-variable" do
            item = Item.new(2,"books",29.99)
            expect(item.tax).to be_instance_of(Tax)
            expect(item.tax.item_desc).to eq(item.item_description)
        end
        it "should return product of qty and price when we call item-price" do
            item=Item.new(2,"books",29.99)
            expect(item.item_price).to eq(59.98)
        end
        
        it "should return total price of the item as 0 if price is zero" do
            item=Item.new(2,"books",0)
            expect(item.item_total).to eq(0)
        end
        it "should return total price of the item including the tax when you call item_total" do
            item=Item.new(2,"books",29.99)
            expect(item.item_total).to eq(59.98)
        end
    end

    context "When passing Invalid arguments to qty" do
        it "should raise a error when you provide invalid input string to the qty" do
            expect{Item.new("a","books",29.99)}.to raise_error(ArgumentError)
        end
        it "should raise a error when you provide invalid input string to the price" do
            expect{Item.new("a","books",29.99)}.to raise_error(ArgumentError)
        end
        it "should raise a error when you provide -ve value to the qty" do
            expect{Item.new(-2,"books",29.99)}.to raise_error(ArgumentError)
        end
        it "should raise a error when you provide 0 value to the qty" do
            expect{Item.new(0,"books",29.99)}.to raise_error(ArgumentError)
        end
        it "should raise a error when you provide -ve value to the price" do
            expect{Item.new(-2.2,"books",29.99)}.to raise_error(ArgumentError)
        end
        it "should raise a error when you provide -ve value to the price" do
            expect{Item.new(2.2,"books",29.99)}.to raise_error(ArgumentError)
        end
    end

    context "When passing Invalid arguments to price" do
        it "should raise a error when you provide invalid input string to the price" do
            expect{Item.new(1,"books","a")}.to raise_error(ArgumentError)
        end
        it "should raise a error when you provide invalid input string to the price" do
            expect{Item.new(1,"books",-29.99)}.to raise_error(ArgumentError)
        end
        it "should raise a error when you provide -ve value to the price" do
            expect{Item.new(1,"books","ab")}.to raise_error(ArgumentError)
        end
        it "should raise a error when you provide -0.1 value to the qty" do
            expect{Item.new(1,"books",-0.1)}.to raise_error(ArgumentError)
        end
    end

end