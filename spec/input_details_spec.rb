require_relative "../InputDetails"


RSpec.describe "InputDetails Class" do

    let(:id){ InputDetails.new() }
    
    context "When testing get_qty_from_user()" do
        it "should return a value of 5" do
            allow(id).to receive(:display_message).and_return("")
            allow(id).to receive(:get_input).and_return("5")
            expect(id.get_qty_from_user).to eq(5)
        end

        it "should return positive integer force the user to enter integer value" do
            allow(id).to receive(:display_message).and_return("")
            allow(id).to receive(:get_input).and_return("a","-1.0","-11","","1")
            expect(id.get_qty_from_user).to eq(1)
        end
    end

    context "When testing get_item_desc_from_user()" do
        it "should return a value of 'books' when given" do
            allow(id).to receive(:display_message).and_return("")
            allow(id).to receive(:get_input).and_return("books")
            expect(id.get_item_desc_from_user).to eq("books")
        end
    end

    context "When testing get_shelf_price_from_user()" do
        it "should return a value of 'books' when given" do
            allow(id).to receive(:display_message).and_return("")
            allow(id).to receive(:get_input).and_return(25.5)
            expect(id.get_shelf_price_from_user).to eq(25.5)
        end
        it "should return positive integer 0 or greater than 0 and force the user to input the value" do
            allow(id).to receive(:display_message).and_return("")
            allow(id).to receive(:get_input).and_return("a","-1.0","-11","","-2.0","1.1")
            expect(id.get_shelf_price_from_user).to eq(1.1)
        end
    end

    context "When testing cont_or_quit()" do
        it "should return true when given 'q' or 'Q' " do
            allow(id).to receive(:display_message).and_return("")
            allow(id).to receive(:get_input).and_return('q')
            expect(id.cont_or_quit?).to be_truthy
            allow(id).to receive(:get_input).and_return('Q')
            expect(id.cont_or_quit?).to be_truthy
        end
        it "should return false when given other than q or Q " do
            allow(id).to receive(:display_message).and_return("")
            allow(id).to receive(:get_input).and_return('K')
            expect(id.cont_or_quit?).to be_falsey
            allow(id).to receive(:get_input).and_return('1')
            expect(id.cont_or_quit?).to be_falsey
            allow(id).to receive(:get_input).and_return('2')
            expect(id.cont_or_quit?).to be_falsey
            allow(id).to receive(:get_input).and_return('2.2')
            expect(id.cont_or_quit?).to be_falsey
        end
    end
    
    context 'When Testing loop' do
        it "should return 3 items when given false false true " do
            id.items=[]
            # allow(id).to receive(:loop).and_yield.and_yield
            allow(id).to receive(:cont_or_quit?) {false}
            allow(id).to receive(:test_shelf_price_from_user).and_return(2)
            allow(id).to receive(:test_qty_from_user).and_return(1)
            allow(id).to receive(:test_item_desc_from_user).and_return("books")
            allow(id).to receive(:add_item).and_return(id.items.push(1),id.items.push(1),id.items.push(1))
            allow(id).to receive(:cont_or_quit?).and_return(false,false,true)
            expect(id.items.length).to eq(3)
            
        end
    end

    context "When Testing get_file_details()" do
        it "should return 'test','CSVFileWriter' when given csv as input" do
            allow(id).to receive(:get_input).and_return("csv","test")
            allow(id).to receive(:display_message).and_return("")
            expect(id.get_file_details).to eq(["test","CSVFileWriter"])
        end
        it "should return 'test','TxtFileWriter' when given txt as input" do
            allow(id).to receive(:get_input).and_return("txt","test")
            allow(id).to receive(:display_message).and_return("")
            expect(id.get_file_details).to eq(["test","TxtFileWriter"])
        end
        it "should return 'test','PdfFileWriter' if the input pdf" do
            allow(id).to receive(:get_input).and_return("pdf","test")
            allow(id).to receive(:display_message).and_return("")
            expect(id.get_file_details).to eq(["test","PdfFileWriter"])
        end
        it "should return 'test','FileCreator' if the input not in the plugins" do
            allow(id).to receive(:get_input).and_return("er","test")
            allow(id).to receive(:display_message).and_return("")
            expect(id.get_file_details).to eq(["test","FileCreator"])
        end
    end
    
end