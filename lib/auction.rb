class Auction 
  attr_reader :items 

  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def item_names
    @items.map { |item| item.name }
  end

  def unpopular_items
    @items.select { |item| item.bids == {} }
  end

  def potential_revenue
    (@items - unpopular_items).sum { |item| item.current_high_bid }
  end 

  def bidders 
    attendees = @items.map { |item| item.bids.keys }.flatten.uniq
    attendees.map { |attendee| attendee.name }
  end

  def bidder_info
    items.each_with_object(Hash.new{ |h,k| h[k] = {budget: 0, items: []}}) do |item, hash|
      item.bids.each do |bidder, bid|
        hash[bidder][:budget] = bidder.budget 
        hash[bidder][:items] << item
      end 
    end
  end
end