require_relative "../TxtFileWriter"
require_relative "../Item"

RSpec.describe "TxtFileWriter Class" do
    
    around(:example,do_csv: true) do |ex|
        headings=["Qty","Item_description","Price","Item_tax"]
        item= Item.new(1,"books",20)
        item.calculated_details()
        @file1= TxtFileWriter.new([item],"test")
        @filepath1=@file1.write(1,20,0)
        @file_loc1= @filepath1+"/test.txt"
        ex.run
        File.delete(@file_loc1)
    end

    context "When testing the write()", do_csv: true do
        it "should return a file path and the file should be created when given txt extension" do
            expect(File.exist? @file_loc1).to be_truthy
        end
        it "should write the data to the file with the content sent to it in the extension format(txt)" do
            expect(File.read(@file_loc1)).to eq("Qty|Item_description|Price|Item_tax\n1|books|20|0.0\ntotal_price: 20\ntotal_tax: 0\n")
        end
    end
    
end