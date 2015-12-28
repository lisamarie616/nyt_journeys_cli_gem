class NytJourneys::Journeys
  attr_accessor :name, :url, :description, :cost, :length, :dates, :itinerary

  @@all = []

  def initialize(trip_hash)
    trip_hash.each {|k,v| self.send("#{k}=",v)}
    @@all << self
  end

  def self.create_from_collection(trip_array)
    trip_array.each {|trip| self.new(trip)}
  end

  def self.all
    @@all
  end
  
end