class Attendee
  attr_reader :info, :name, :budget 
  def initialize(info)
    @info = info
    @name = @info[:name]
    @budget = @info[:budget].delete('$').to_i
  end
end