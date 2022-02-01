# require "../Tax"
require_relative "../Tax"
require_relative "../Item"


RSpec.describe "Tax" do

    context "When testing the imported?" do
        it "should say 'imported' if the item_desc contains imported word(valid)" do
            item=double(Item,:item_description=>"books imported",:price=>30.02)
            tax=Tax.new(item)
            expect(tax.imported?).to be_truthy
        end
        it "should say 'not imported' if the item_desc does not contain imported word" do
            item=double(Item,:item_description=>"books",:price=>30.02)
            tax=Tax.new(item)
            expect(tax.imported?).to be_falsy
        end
    end

    context "When testing the exempted?" do
        it "should say 'exempted' if the item is in any of the book,food,medical products" do
            item=double(Item,:item_description=>"books imported",:price=>39.99)
            tax=Tax.new(item)
            expect(tax.exempted?).to be_truthy
        end
        it "should say 'not exempted' if the item is not in any of the book,food,medical products" do
            item=double(Item,:item_description=>"shelf imported",:price=>39.99)
            tax=Tax.new(item)
            expect(tax.exempted?).to be_falsy
        end
    end

    context "When passing combinations of imported and exempted items to the calculate()" do

        it "should calculate tax to 15% if the item is not exempted and imported" do
            item=double(Item,:item_description=>"imported box of perfume",:price=>27.99)
            tax=Tax.new(item)
            expect(tax.calculate()).to eq(4.2)
        end

        it "should calculate tax to 10% if the item is not exempted and not imported" do
            item=double(Item,:item_description=>"bottle of perfume",:price=>27.99)
            tax=Tax.new(item)
            expect(tax.calculate()).to eq(2.8)
        end
        
        it "should calculate tax to 5% if the item is imported and not exempted" do
            item=double(Item,:item_description=>"imported book",:price=>30.99)
            tax=Tax.new(item)
            expect(tax.calculate()).to eq(1.55)
        end
    end

    context "When passing price=0 to the calculate()" do

        it "should return 0 if price is zero" do
            item=double(Item,:item_description=>"bottle of perfume",:price=>0)
            tax=Tax.new(item)
            expect(tax.calculate()).to eq(0)
        end

    end

    context "When passing Invalid arguments to the calculate()" do
        it "should raise a Argument error" do
            item=double(Item,:item_description=>"bottle of perfume",:price=>"ab")
            tax=Tax.new(item)
            expect{tax.calculate()}.to raise_error(ArgumentError)
        end
    end

end