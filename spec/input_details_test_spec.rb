require_relative "../InputDetailsValidation"

RSpec.describe "When Testing InputDetails Tesing" do

    let(:id){ InputDetailsTesting.new() }

    context "When Testing qty_test() " do
        it "should return integer if the input is integer" do
            expect(id.qty_test("5")).to eq(5)
        end
        it "should raise an error if the input is -ve" do
            # allow(id).to receive(:get_input).and_return("-5")
            expect{id.qty_test("-5")}.to raise_error(ArgumentError)
        end
        it "should raise an error if the input is float value" do
            # allow(id).to receive(:get_input).and_return("5.3")
            expect{id.qty_test("5.3")}.to raise_error(ArgumentError)
        end
        it "should raise an error if the input is -ve float value" do
            # allow(id).to receive(:get_input).and_return("-5.3")
            expect{id.qty_test("-5.3")}.to raise_error(ArgumentError)
        end
        it "should raise an error if the input is string" do
            # allow(id).to receive(:get_input).and_return("a")
            expect{id.qty_test("a")}.to raise_error(ArgumentError)
        end
        it "should raise an error if the input is empty" do
            # allow(id).to receive(:get_input).and_return("")
            expect{id.qty_test("")}.to raise_error(ArgumentError)
        end
    end

    context "When Testing shelf_price_test() " do
        it "should return integer if the input is integer" do
            # allow(id).to receive(:get_input).and_return("5")
            expect(id.price_test("5")).to eq(5.0)
        end
        it "should raise an error if the input is -ve" do
            # allow(id).to receive(:get_input).and_return("-5.3")
            expect{id.price_test("-5.3")}.to raise_error(ArgumentError)
        end
        it "should raise an error if the input is string" do
            # allow(id).to receive(:get_input).and_return("a")
            expect{id.price_test("a")}.to raise_error(ArgumentError)
        end
        it "should raise an error if the input is empty" do
            # allow(id).to receive(:get_input).and_return("")
            expect{id.price_test("")}.to raise_error(ArgumentError)
        end
    end
    
end