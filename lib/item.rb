class Item 
  attr_reader :name,
              :bids

  def initialize(name)
    @name = name
    @bids = {}
    @bidding_closed = false
  end

  def bidding_closed?
    @bidding_closed
  end

  def add_bid(attendee, amount)
    @bids[attendee] = amount if @bidding_closed == false
  end

  def current_high_bid
    @bids.values.max
  end

  def close_bidding 
    @bidding_closed = true
  end
end