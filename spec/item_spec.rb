require "rspec"
require "./lib/item"

RSpec.describe Item do 
  before(:each) do 
    @item1 = Item.new("Chalkware Piggy Bank")
    @attendee1 = Attendee.new({name: "Megan", budget: "$50"})
    @attendee2 = Attendee.new({name: "Bob", budget: "$75"})
  end

  describe "#initialize" do 
    it "exists" do 
      expect(@item1).to be_an_instance_of(Item)
    end

    it "has a readable name" do 
      expect(@item1.name).to eq("Chalkware Piggy Bank")
    end

    it "starts out with no bids" do 
      expect(@item1.bids).to eq({})
    end
  end

  describe "#add_bid" do 
    it "adds bids to the item" do 
      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      expect(@item1.bids).to eq({@attendee2 => 20, @attendee1 => 22})
    end
  end

  describe "#current_high_bid" do 
    it "returns the highest bid for the item" do 
      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      expect(@item1.current_high_bid).to eq(22)
    end
  end
end