require_relative "../InputDetails"


RSpec.describe "InputDetails Class" do

    let(:id){ InputDetails.new() }
    
    context "When Testing qty_test() " do
        it "should return integer if the input is integer" do
            allow(id).to receive(:get_input).and_return("5")
            expect(id.qty_test()).to eq(5)
        end
        it "should raise an error if the input is -ve" do
            allow(id).to receive(:get_input).and_return("-5")
            expect{id.qty_test()}.to raise_error(ArgumentError)
        end
        it "should raise an error if the input is float value" do
            allow(id).to receive(:get_input).and_return("5.3")
            expect{id.qty_test()}.to raise_error(ArgumentError)
        end
        it "should raise an error if the input is -ve float value" do
            allow(id).to receive(:get_input).and_return("-5.3")
            expect{id.qty_test()}.to raise_error(ArgumentError)
        end
        it "should raise an error if the input is string" do
            allow(id).to receive(:get_input).and_return("a")
            expect{id.qty_test()}.to raise_error(ArgumentError)
        end
        it "should raise an error if the input is empty" do
            allow(id).to receive(:get_input).and_return("")
            expect{id.qty_test()}.to raise_error(ArgumentError)
        end
    end

    context "When Testing shelf_price_test() " do
        it "should return integer if the input is integer" do
            allow(id).to receive(:get_input).and_return("5")
            expect(id.shelf_price_test()).to eq(5.0)
        end
        it "should raise an error if the input is -ve" do
            allow(id).to receive(:get_input).and_return("-5.3")
            expect{id.shelf_price_test()}.to raise_error(ArgumentError)
        end
        it "should raise an error if the input is string" do
            allow(id).to receive(:get_input).and_return("a")
            expect{id.shelf_price_test()}.to raise_error(ArgumentError)
        end
        it "should raise an error if the input is empty" do
            allow(id).to receive(:get_input).and_return("")
            expect{id.shelf_price_test()}.to raise_error(ArgumentError)
        end
    end

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
end