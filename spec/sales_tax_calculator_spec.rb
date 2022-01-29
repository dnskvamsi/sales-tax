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


    context "When testing Generate Class" do
        it "should return a data with respect to the items" do
            gene=Generate.new()
            item1=Item.new(2,"books",20)
            item2=Item.new(3,"books",20)
            allow(gene).to receive(:get_items_from_the_user).and_return([item1,item2])
            allow(gene).to receive(:fetch_conversion_rates).and_return(1)
            allow(gene).to receive(:get_file_details).and_return(["testing",".csv",","])
            allow(gene).to receive(:total_calculator).and_return([100,0])
            expect(gene.data_generator).to eq([
                ["Qty", "Item_description", "Price", "Item_tax"],
                [2, "books", 20, 0.0],
                [3, "books", 20, 0.0], 
                ["total_price: 100"],
                ["total_tax: 0"]])
            File.delete("testing.csv")
        end
    end
end