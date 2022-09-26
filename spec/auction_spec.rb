require "rspec"
require "./lib/item"
require "./lib/attendee"
require "./lib/auction"

RSpec.describe Auction do 
  before(:each) do 
    @item1 = Item.new("Chalkware Piggy Bank")
    @item2 = Item.new("Bamboo Picture Frame")
    @item3 = Item.new("Homemade Chocolate Chip Cookies")
    @item4 = Item.new("2 Days Dogsitting")
    @item5 = Item.new("Forever Stamps")
    @attendee1 = Attendee.new({name: "Megan", budget: "$50"})
    @attendee2 = Attendee.new({name: "Bob", budget: "$75"})
    @attendee3 = Attendee.new({name: "Mike", budget: "$100"})
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

  describe "#item_names" do 
    it "lists the names of all items at the auction" do 
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      expect(@auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
    end
  end

  describe "#unpopular_items" do 
    it "lits the items at the auction which have no bids" do 
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
      @item1.add_bid(@attendee1, 22)
      @item1.add_bid(@attendee2, 20)
      @item4.add_bid(@attendee3, 50)
      expect(@auction.unpopular_items).to eq([@item2, @item3, @item5])
      @item3.add_bid(@attendee2, 15)
      expect(@auction.unpopular_items).to eq([@item2, @item5])
    end
  end

  describe "#potential_revenue" do 
    it "returns the sum of all items' current highest bids" do 
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
      @item1.add_bid(@attendee1, 22)
      @item1.add_bid(@attendee2, 20)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)
      expect(@auction.potential_revenue).to eq(87)
    end
  end

  describe "#bidders" do 
    it "returns a list of all the bidders' names" do 
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
      @item1.add_bid(@attendee1, 22)
      @item1.add_bid(@attendee2, 20)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)
      expect(@auction.bidders).to eq(["Megan", "Bob", "Mike"])
    end
  end

  describe "#bidder_info" do 
    it "returns a hash with Attendee keys and info hashes as values" do 
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
      @item1.add_bid(@attendee1, 22)
      @item1.add_bid(@attendee2, 20)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)
      expected_result = {
                          @attendee1 =>
                            {
                              :budget => 50,
                              :items => [@item1]
                            },
                          @attendee2 =>
                            {
                              :budget => 75,
                              :items => [@item1, @item3]
                            },
                          @attendee3 =>
                            {
                              :budget => 100,
                              :items => [@item4]
                            }
                        }
      expect(@auction.bidder_info).to eq(expected_result)
    end 
  end

  describe "#date" do 
    it "returns a formatted date" do 
      allow(@auction).to receive(:creation_date).and_return(Date.new(2020,2,24))
      expect(@auction.date).to eq("24/02/2020")
    end
  end

  describe "#close_auction" do 
    before(:each) do 
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
      @item1.add_bid(@attendee1, 22)
      @item1.add_bid(@attendee2, 20)
      @item4.add_bid(@attendee2, 30)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)
      @item5.add_bid(@attendee1, 35)
    end 

    it "closes bidding for all items" do 
      @auction.close_auction
      expect(@auction.items.all? { |item| item.bidding_closed? }).to eq(true)
    end

    it "returns a hash with Items as keys and the Attendee who bought the item (or 'Not Sold') as values" do 
      expected_result = {
                          @item1 => @attendee1,
                          @item2 => 'Not Sold',
                          @item3 => @attendee2,
                          @item4 => @attendee3,
                          @item5=> @attendee1
                        }
      expect(@auction.close_auction).to eq(expected_result)
    end
  end
end