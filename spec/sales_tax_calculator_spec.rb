require_relative "../sales_tax_calculator"
require_relative "../Item"
require_relative "../Tax"
require_relative "../InputDetails"
require_relative "../Conversion"

RSpec.describe "sales_tax_calculator" do

    context "When testing Generate Class" do
        it "should return a data with respect to the items" do
            item1=Item.new(2,"books",20)
            item2=Item.new(3,"books",20)
            input=double(InputDetails,:get_items_from_the_user=>[item1,item2],
                :get_file_details=>["testing","CSVFileWriter"],
                :total_calculator=>[100,0])
            conversion=double(CoversionData,:fetch_conversion_rates=>1)
            gene=Generate.new(input,conversion)

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