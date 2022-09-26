class Attendee 
  attr_reader :name,
              :budget 
              
  def initialize(details_hash)
    @name = details_hash[:name]
    @budget = details_hash[:budget][1..-1].to_i
  end
end