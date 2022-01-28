require "../Tax"
require "../Item"
RSpec.describe "Item" do
    context "When testing the Item Class" do
        it "should be a instance of tax object when we call tax-variable" do
            item = Item.new(2,"books",29.99)
            expect(item.tax).to be_instance_of(Tax)
            expect(item.tax.item_desc).to eq(item.item_description)
        end
        it "should return product of qty and price when we call item-price" do
            item=Item.new(2,"books",29.99)
            expect(item.item_price).to eq(59.98)
        end
        it "should raise a error when you provide invalid input to the qty" do
            expect{Item.new("a","books",29.99)}.to raise_error(ArgumentError)
        end
        it "should raise a error when you provide invalid input to the price" do
            expect{Item.new("a","books",29.99)}.to raise_error(ArgumentError)
        end
        it "should return total price of the item including the tax when you call item_total" do
            item=Item.new(2,"books",29.99)
            expect(item.item_total).to eq(59.98)
        end
    end
end