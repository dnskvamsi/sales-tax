require_relative "../FileCreate"

RSpec.describe "FileCreator Class" do
    around(:example,do_csv: true) do |ex|
        @file= FileCreator.new([[1,2],[2,3]],"test",".csv",",")
        @filepath=@file.write()
        @file_loc= @filepath+"/test.csv"
        @file1= FileCreator.new([[1,2],[2,3]],"test1",".txt","|")
        @filepath1=@file1.write()
        @file_loc1= @filepath1+"/test1.txt"
        ex.run
        File.delete(@file_loc)
        File.delete(@file_loc1)
    end
    context "When testing the write()", do_csv: true do
        it "should return a file path and the file should be created when given csv extension" do
            expect(File.exist? @file_loc).to be_truthy
        end
        it "should write the data to the file with the content sent to it in the extension format(csv)" do
            expect(File.read(@file_loc)).to eq("1,2\n2,3\n")
        end
        it "should return a file path and the file should be created when given txt extension" do
            expect(File.exist? @file_loc1).to be_truthy
        end
        it "should write the data to the file with the content sent to it in the extension format(txt)" do
            expect(File.read(@file_loc1)).to eq("1|2\n2|3\n")
        end
    end
end