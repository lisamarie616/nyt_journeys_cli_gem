class NytJourneys::Journeys
  attr_accessor :name, :url, :type, :description

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

  def doc
    Nokogiri::HTML(open(url))
  end

  def description
    description = ""
    doc.css("div.trip-description p").each do |paragraph|
      description << "#{paragraph.text} "
    end
    description = description.strip.gsub(/(\n)/," ")
  end

  def cost
    cost ||= doc.css("div.price p").text[/\$\S+/]
  end

  def length
    length ||= doc.css("div.itinerary-info > p").text.strip[/.+s/]
  end

  def dates
    dates ||= doc.css("div.departures a.departure-link").collect {|date_range| date_range.text}
  end

  def itinerary
    itinerary ||= doc.css("div.primary-information").collect do |day|
      "#{day.css("div.day-number").text} - #{day.css("h3.day-title").text}"
    end
  end
  
end