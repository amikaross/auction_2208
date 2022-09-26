require "./lib/item"

RSpec.describe Item do 
  beofre(:each) do 
    @item1 = Item.new("Chalkware Piggy Bank")
  end
  describe "#initialize" do 
    it "exists" do 
      expect(@item1).to be_an_instance_of(Item)
    end

    it "has a readable name" do 
      expect(@item1.name).to eq("Chalkware Piggy Bank")
    end
  end
end