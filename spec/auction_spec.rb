require "rspec"
require "./lib/item"
require "./lib/auction"

RSpec.describe Auction do 
  before(:each) do 
    @item1 = Item.new("Chalkware Piggy Bank")
    @item2 = Item.new("Bamboo Picture Frame")
    @auction = Auction.new
  end

  describe "#initialize" do 
    it "exists" do 
      expect(@auction).to be_an_instance_of(Auction)
    end

    it "starts out with no items" do 
      expect(@auction.items).to eq([])
    end
  end

  describe "#add_item" do 
    it "adds items to the auction" do 
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      expect(@auction.items).to eq([@item1, @item2])
    end
  end

  dsecribe "#item_names" do 
    it "lists the names of all items at the auction" do 
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      expect(@auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
    end
  end
end