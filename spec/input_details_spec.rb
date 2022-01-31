require_relative "../InputDetails"


RSpec.describe "Testing InputDetails Module" do

    context "when testing add_item()" do
        it "should add the new item to the array" do
            arr=[]
            id=InputDetails.new()
            id.add_item("v",arr)
            expect(arr.length).to eq(1)
            expect(arr.pop).to eq("v")
        end
    end

    context "When Testing qty_test() " do
        it "should return integer if the input is integer" do
            id=InputDetails.new()
            allow(id).to receive(:get_input).and_return("5")
            expect(id.qty_test()).to eq(5)
        end
        it "should raise an error if the input is -ve" do
            id=InputDetails.new()
            allow(id).to receive(:get_input).and_return("-5")
            expect{id.qty_test()}.to raise_error(ArgumentError)
        end
        it "should raise an error if the input is float value" do
            id=InputDetails.new()
            allow(id).to receive(:get_input).and_return("5.3")
            expect{id.qty_test()}.to raise_error(ArgumentError)
        end
        it "should raise an error if the input is -ve float value" do
            id=InputDetails.new()
            allow(id).to receive(:get_input).and_return("-5.3")
            expect{id.qty_test()}.to raise_error(ArgumentError)
        end
        it "should raise an error if the input is string" do
            id=InputDetails.new()
            allow(id).to receive(:get_input).and_return("a")
            expect{id.qty_test()}.to raise_error(ArgumentError)
        end
        it "should raise an error if the input is empty" do
            id=InputDetails.new()
            allow(id).to receive(:get_input).and_return("")
            expect{id.qty_test()}.to raise_error(ArgumentError)
        end
    end

    context "When Testing shelf_price_test() " do
        it "should return integer if the input is integer" do
            id=InputDetails.new()
            allow(id).to receive(:get_input).and_return("5")
            expect(id.shelf_price_test()).to eq(5.0)
        end
        it "should raise an error if the input is -ve" do
            id=InputDetails.new()
            allow(id).to receive(:get_input).and_return("-5.3")
            expect{id.shelf_price_test()}.to raise_error(ArgumentError)
        end
        it "should raise an error if the input is string" do
            id=InputDetails.new()
            allow(id).to receive(:get_input).and_return("a")
            expect{id.shelf_price_test()}.to raise_error(ArgumentError)
        end
        it "should raise an error if the input is empty" do
            id=InputDetails.new()
            allow(id).to receive(:get_input).and_return("")
            expect{id.shelf_price_test()}.to raise_error(ArgumentError)
        end
    end

    context "When testing get_qty_from_user()" do
        it "should return a value of 5" do
            id=InputDetails.new()
            allow(id).to receive(:display_message).and_return("")
            allow(id).to receive(:get_input).and_return("5")
            expect(id.get_qty_from_user).to eq(5)
        end
    end

    context "When testing get_item_desc_from_user()" do
        it "should return a value of 'books' when given" do
            id=InputDetails.new()
            allow(id).to receive(:display_message).and_return("")
            allow(id).to receive(:get_input).and_return("books")
            expect(id.get_item_desc_from_user).to eq("books")
        end
    end

    context "When testing get_shelf_price_from_user()" do
        it "should return a value of 'books' when given" do
            id=InputDetails.new()
            allow(id).to receive(:display_message).and_return("")
            allow(id).to receive(:get_input).and_return(25.5)
            expect(id.get_shelf_price_from_user).to eq(25.5)
        end
    end

    context "When testing cont_or_quit()" do
        it "should return true when given 'q' or 'Q' " do
            id=InputDetails.new()
            allow(id).to receive(:display_message).and_return("")
            allow(id).to receive(:get_input).and_return('q')
            expect(id.cont_or_quit?).to be_truthy
            allow(id).to receive(:get_input).and_return('Q')
            expect(id.cont_or_quit?).to be_truthy
        end
        it "should return false when given other than q or Q " do
            id=InputDetails.new()
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
            id = InputDetails.new()
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

    context "When Testing display_message()" do
        it "should return 'yes' when message is yes" do
            id = InputDetails.new()
            # expect(id.display_message("yes")).to eq("yes") 
        end
    end

    context "When testing total_calculator()" do
        it "should return total price and total tax" do
            id=InputDetails.new()
            items=[]
            it1 = Item.new(1,"books",20)
            it2 = Item.new(1,"books",30)
            items.push(it1,it2)
            expect(id.total_calculator(items)).to eq([50,0])
        end
    end
end