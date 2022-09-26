class Auction
  attr_reader :items, :date 
  def initialize
    @items = []
  end

  def add_item(item)
    @items << item 
  end

  def item_names
    @items.map {|item| item.name}
  end

  def unpopular_items
    @items.select {|item| item.bids == {}}
  end

  def potential_revenue
    @items.map {|item| item.current_high_bid}.compact.sum
  end

  def bidders
    @items.map {|item| item.bids.map {|attendee, amount| attendee.name}}.flatten.uniq
  end

  def bidder_info
    @info = {}
    @items.each do |item|
      item.bids.each do |attendee, amount|
        @info[attendee] = {:budget => attendee.budget, :items => bidder_items(attendee)}
      end 
    end
    @info 
  end

  def bidder_items(an_attendee)
    @items.select {|item| item if item.bids.find {|attendee, amount| attendee == an_attendee}}
  end

  def date 
    Date.today.strftime('%d/%m/%Y') 
  end

  #####everything below is in progress and i commented out its testing####

  def close_auction
    # item as key, value is attendee w/ highest bid or 'not sold'
    @closed ={}
    @items.each do |item|
      # item.close_bidding
      item.bids.each do |attendee, amount|
      #   @closed[item] = helper

        if item.bids != {}
          if  item_sold_to(item) == nil
            @closed[item] = 'Not Sold'
          else 
          @closed[item] = item_sold_to(item)
          end 
        end
        @closed[bidder_items(attendee)] = item_sold_to(item)
      end 
    end
    @closed 
        #       @closed[item] = item_sold_to(item)
    #   if item.bids != {}
    #     item.bids.each do |attendee, amount|
    #       @closed[item] = item_sold_to(item)
    #     end 
    #   else
    #     item.bids.each do |attendee, amount|
    #       @closed[item] = 'Not Sold'
    #     end
    #   end
    # end
    # @closed 
  end

  def item_sold_to(an_item) 
    if an_item.bids == {}
      nil
    else 
      an_item.bids.find {|attendee, amount| attendee if amount == an_item.current_high_bid}
    end
  end

  def attendants_bought
    @items.map {|item| item_sold_to(item)}.flatten 
  end

  def helper
    if attendants_bought == nil
      'Not Sold'
    else
      attendants_bought
    end
  end
end