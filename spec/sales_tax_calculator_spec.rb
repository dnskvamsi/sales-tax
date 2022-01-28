require_relative "../sales_tax_calculator"
require_relative "../Item"
require_relative "../Tax"

RSpec.describe "sales-tax-calculation" do
    around(:example,do_csv: true) do |ex|
        @file= FileCreator.new([[1,2],[2,3]],"test",".csv",",")
        @filepath=@file.write()
        @file_loc= @filepath+"/test.csv"
        @file1= FileCreator.new([[1,2],[2,3]],"test1",".txt",",")
        @filepath1=@file1.write()
        @file_loc1= @filepath1+"/test1.txt"
        ex.run
        File.delete(@file_loc)
        File.delete(@file_loc1)
    end
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

    context "When testing the FileCreator class", do_csv: true do
        it "should return a file path and the file should be created when given csv extension" do
            expect(File.exist? @file_loc).to be_truthy
        end
        it "should return a file path and the file should be created when given txt extension" do
            expect(File.exist? @file_loc1).to be_truthy
        end
    end
end