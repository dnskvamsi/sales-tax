# require "../Tax"
require_relative "../Tax"


RSpec.describe "Tax" do

    context "When testing the imported?" do
        it "should say 'imported' if the item_desc contains imported word(valid)" do
            tax=Tax.new("book imported",30.2)
            expect(tax.imported?).to be_truthy
        end
        it "should say 'not imported' if the item_desc does not contain imported word" do
            tax=Tax.new("book",30.2)
            expect(tax.imported?).to be_falsy
        end
    end

    context "When testing the exempted?" do
        it "should say 'exempted' if the item is in any of the book,food,medical products" do
            tax= Tax.new("book imported",30.2)
            expect(tax.exempted?).to be_truthy
        end
        it "should say 'not exempted' if the item is not in any of the book,food,medical products" do
            tax= Tax.new("shelf imported",30.2)
            expect(tax.exempted?).to be_falsy
        end
    end

    context "When passing combinations of imported and exempted items to the calculate()" do
        it "should calculate tax to 15% if the item is not exempted and imported" do
            tax= Tax.new("imported box of perfume",27.99)
            expect(tax.calculate()).to eq(4.2)
        end
        it "should calculate tax to 10% if the item is not exempted and not imported" do
            tax= Tax.new("bottle of perfume",27.99)
            expect(tax.calculate()).to eq(2.8)
        end
        it "should calculate tax to 5% if the item is imported and not exempted" do
            tax=Tax.new("imported book",30.99)
            expect(tax.calculate()).to eq(1.55)
        end
    end

    context "When passing price=0 to the calculate()" do
        it "should return 0 if price is zero" do
            tax=Tax.new("bottle of perfume",0)
            expect(tax.calculate()).to eq(0)
        end
    end

    context "When passing Invalid arguments to the calculate()" do
        it "should raise a Argument error" do
            tax=Tax.new("bottle of perfume","ab")
            expect{tax.calculate()}.to raise_error(ArgumentError)
        end
    end

end