require_relative "../TxtFileWriter"

RSpec.describe "TxtFileWriter Class" do
    
    around(:example,do_csv: true) do |ex|
        @file1= TxtFileWriter.new([[1,2],[2,3]],"test")
        @filepath1=@file1.write()
        @file_loc1= @filepath1+"/test.txt"
        ex.run
        File.delete(@file_loc1)
    end

    context "When testing the write()", do_csv: true do
        it "should return a file path and the file should be created when given txt extension" do
            expect(File.exist? @file_loc1).to be_truthy
        end
        it "should write the data to the file with the content sent to it in the extension format(txt)" do
            expect(File.read(@file_loc1)).to eq("1|2\n2|3\n")
        end
    end
    
end