class NytJourneys::Scraper
  
  # type_name: .css("h3.trip-type-list-title").text
  # type_url: .css("a.view-all-link").attribute("href").value
  def self.scrape_type_summary_page(summary_url = "http://www.nytimes.com/times-journeys/trip-type/")
    type_summary = Nokogiri::HTML(open(summary_url))
    types = []
    type_summary.css("div.trip-type-listings").each do |type|
      type_hash = {}
      type_hash[:type_name] = type.css("h3.trip-type-list-title").text
      type_hash[:type_url] = type.css("a.view-all-link").attribute("href").value
      types << type_hash
    end
    types  # an array of type hashes with type_name and type_url properties
  end

  # trip_name: .css("h2.item-title").text
  # trip_url: .css.attribute("href").value
  def self.scrape_type_detail_page(details_url)
    type_details = Nokogiri::HTML(open(details_url))
    trips =[]
    type_details.css("li.journey-list-item > a").each do |trip|
      trips_hash = {}
      trips_hash[:name] = trip.css("h2.item-title").text
      trips_hash[:url] = trip.attribute("href").value
      trips << trips_hash
    end
    trips  # an array of trip hashes with name and url properties
  end

  # description: trip_details.css("div.trip-description p")
  # cost: trip_details.css("div.price p").text
  # length: trip_details.css("div.itinerary-info > p").text
  # dates: div.departures a.departure-link
  # itinerary: div.primary-information, div.day-number, h3.day-title
  def self.scrape_trip_page(trip_url="http://www.nytimes.com/times-journeys/travel/cuba-times-now/")
    trip_details = Nokogiri::HTML(open(trip_url))
    trip = {}

    trip[:description] = ""
    trip_details.css("div.trip-description p").each do |paragraph|
      trip[:description] << "#{paragraph.text} "
    end
    trip[:description].gsub!(/(\n)/," ").strip!

    trip[:cost] = trip_details.css("div.price p").text[/(\d|,)+/].gsub(",","").to_i
    trip[:length] = trip_details.css("div.itinerary-info > p").text.strip[/.+s/]

    trip[:dates] = []
    trip_details.css("div.departures a.departure-link").each do |dates|
      trip[:dates] << dates.text
    end

    trip[:itinerary] = []
    trip_details.css("div.primary-information").each do |day|
      trip[:itinerary] << "#{day.css("div.day-number").text} - #{day.css("h3.day-title").text}"
    end
    trip
  end
  
end