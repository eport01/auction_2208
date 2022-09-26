require './lib/item'
require './lib/auction'
require './lib/attendee'
require 'date' 

RSpec.describe Auction do 
  before(:each) do 
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
    @item3 = Item.new('Homemade Chocolate Chip Cookies')
    @item4 = Item.new('2 Days Dogsitting')
    @item5 = Item.new('Forever Stamps')
    @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
    @attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
    @attendee3 = Attendee.new({name: 'Mike', budget: '$100'})
    @attendee = Attendee.new({name: 'Megan', budget: '$50'})
    @auction = Auction.new
  end

  it 'exists' do 
    expect(@auction).to be_an_instance_of(Auction)
  end

  it 'starts with an empty array for items' do 
    expect(@auction.items).to eq([])
  end

  it 'can add items and return the items in the items array' do 
    @auction.add_item(@item1)
    @auction.add_item(@item2)
    expect(@auction.items).to eq([@item1, @item2])
  end

  it 'can return an array of item names' do 
    @auction.add_item(@item1)
    @auction.add_item(@item2)
    expect(@auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
  end

  it 'can return an array of unpopular items' do 
    @auction.add_item(@item1)
    @auction.add_item(@item2)
    @auction.add_item(@item3)
    @auction.add_item(@item4)
    @auction.add_item(@item5)
    @item1.add_bid(@attendee2, 20)
    @item1.add_bid(@attendee1, 22)
    @item4.add_bid(@attendee3, 50)
    expect(@auction.unpopular_items).to eq([@item2, @item3, @item5])
    @item3.add_bid(@attendee2, 15)
    expect(@auction.unpopular_items).to eq([@item2, @item5])

  end

  it 'can return the potential revenue at the auction' do 
    @auction.add_item(@item1)
    @auction.add_item(@item2)
    @auction.add_item(@item3)
    @auction.add_item(@item4)
    @auction.add_item(@item5)
    @item1.add_bid(@attendee2, 20)
    @item1.add_bid(@attendee1, 22)
    @item4.add_bid(@attendee3, 50)
    @item3.add_bid(@attendee2, 15)
    expect(@auction.potential_revenue).to eq(87)
  end

  it 'can return an array of bidder names' do 
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

  it 'can return a hash of bidder info' do 
    @auction.add_item(@item1)
    @auction.add_item(@item2)
    @auction.add_item(@item3)
    @auction.add_item(@item4)
    @auction.add_item(@item5)
    @item1.add_bid(@attendee1, 22)
    @item1.add_bid(@attendee2, 20)
    @item4.add_bid(@attendee3, 50)
    @item3.add_bid(@attendee2, 15)

    expected = {
      @attendee1 => {:budget => 50, :items => [@item1]},
      @attendee2 => {:budget => 75, :items => [@item1, @item3]},
      @attendee3 => {:budget => 100, :items => [@item4]}
    }
    expect(@auction.bidder_info).to eq(expected)
  end

  it 'returns a date' do 
    @auction.add_item(@item1)
    @auction.add_item(@item2)
    @auction.add_item(@item3)
    @auction.add_item(@item4)
    @auction.add_item(@item5)

    allow(Date).to receive(:today).and_return(Date.new(2020,2,24))
    expect(@auction.date).to eq("24/02/2020")
  end

#   it 'can be closed' do 
#     @auction.add_item(@item1)
#     @auction.add_item(@item2)
#     @auction.add_item(@item3)
#     @auction.add_item(@item4)
#     @auction.add_item(@item5)
#     @item1.add_bid(@attendee1, 22)
#     @item1.add_bid(@attendee2, 20)
#     @item4.add_bid(@attendee2, 30)
#     @item4.add_bid(@attendee3, 50)
#     @item3.add_bid(@attendee2, 15)
#     @item5.add_bid(@attendee1, 35)
# # require 'pry'; binding.pry
#     expect(@auction.close_auction).to eq(
#       {
#         @item1 => @attendee1,
#         @item2 => 'Not Sold',
#         @item3 => @attendee2,
#         @item4 => @attendee3,
#         @item5 => @attendee1
#       }  
#     )
#   end
end