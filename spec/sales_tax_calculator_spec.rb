require_relative "../sales_tax_calculator"
require_relative "../Item"
require_relative "../Tax"

RSpec.describe "sales-tax-calculation" do
    context "when testing add_item()" do
        it "should add the new item to the array" do
            arr=[]
            add_item("v",arr)
            expect(arr.length).to eq(1)
            expect(arr.pop).to eq("v")
        end
    end
    context "When testing total_calculator()" do
        it "should return total price and total tax" do
            items=[]
            it1 = Item.new(1,"books",20)
            it2 = Item.new(1,"books",30)
            items.push(it1,it2)
            expect(total_calculator(items)).to eq([50,0])
        end
    end
end