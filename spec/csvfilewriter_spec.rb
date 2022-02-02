require_relative "../CSVFileWriter"
require_relative "../Item"

RSpec.describe "CSVFileWriter Class" do
    around(:example,do_csv: true) do |ex|
        headings=["Qty","Item_description","Price","Item_tax"]
        item= Item.new(1,"books",20)
        item.calculated_details()
        @file= CSVFileWriter.new([item],"test")
        @filepath= @file.write(1,20,0)
        puts(@filepath)
        @file_loc= @filepath+"/test.csv"
        ex.run
        File.delete(@file_loc)
    end

    context "When testing the write()", do_csv: true do

        it "should return a file path and the file should be created when given csv extension" do
            expect(File.exist? @file_loc).to be_truthy
        end
        
        it "should write the data to the file with the content sent to it in the extension format(csv)" do
            expect(File.read(@file_loc)).to eq("Qty,Item_description,Price,Item_tax\n1,books,20,0.0\ntotal_price: 20\ntotal_tax: 0\n")
        end
        
    end
end