require_relative "../CSVFileWriter"

RSpec.describe "CSVFileWriter Class" do
    around(:example,do_csv: true) do |ex|
        @file= CSVFileWriter.new([[1,2],[2,3]],"test")
        @filepath=@file.write()
        @file_loc= @filepath+"/test.csv"
        ex.run
        File.delete(@file_loc)
    end

    context "When testing the write()", do_csv: true do

        it "should return a file path and the file should be created when given csv extension" do
            expect(File.exist? @file_loc).to be_truthy
        end
        
        it "should write the data to the file with the content sent to it in the extension format(csv)" do
            expect(File.read(@file_loc)).to eq("1,2\n2,3\n")
        end
        
    end
end