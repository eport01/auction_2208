class Item 
  attr_reader :name, :bids 
  def initialize(name)
    @name = name
    @bids = Hash.new(0)
    @closed = false
  end

  def add_bid(attendee, amount)
    if @closed == false 
      @bids[attendee] += amount 
    else 
    end 
  end

  def current_high_bid
    @bids.values.max
  end

  def close_bidding
    @closed = true 

  end
end