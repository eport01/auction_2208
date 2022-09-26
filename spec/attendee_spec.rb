require './lib/item'
require './lib/auction'
require './lib/attendee'

RSpec.describe Attendee do 
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
    expect(@attendee).to be_an_instance_of(Attendee)
  end

  it 'has a name' do 
    expect(@attendee.name).to eq('Megan')
  end

  it 'has a budget' do 
    expect(@attendee.budget).to eq(50)

  end


end