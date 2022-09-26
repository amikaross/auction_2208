require "rspec"
require "./lib/attendee"

RSpec.describe Attendee do 
  before(:each) do 
    @attendee = Attendee.new({name: "Megan", budget: "$50"})
  end

  describe "#initialize" do 
    it "exists" do 
      expect(@attendee).to be_an_instance_of(Attendee)
    end

    it "has a readable name" do 
      expect(@attendee.name).to eq("Megan")
    end

    it "has a readable budget" do 
      expect(@attendee.budget).to eq(50)
    end
  end
end