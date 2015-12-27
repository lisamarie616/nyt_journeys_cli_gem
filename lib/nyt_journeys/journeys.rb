class NytJourneys::Journeys
  attr_accessor :name, :url, :description, :cost, :length, :dates, :itinerary

  def initialize(name, url)
    @name = name
    @url = url
  end
  
end