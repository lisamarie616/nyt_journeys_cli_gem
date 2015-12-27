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
    types
  end

  # trip_name: .css("h2.item-title").text
  # trip_url: .css.attribute("href").value
  def self.scrape_type_detail_page(details_url="http://www.nytimes.com/times-journeys/trip-type/activities-and-sports/")
    type_details = Nokogiri::HTML(open(details_url))
    
    trips =[]

    type_details.css("li.journey-list-item > a").each do |trip|
      trips_hash = {}
      trips_hash[:name] = trip.css("h2.item-title").text
      trips_hash[:url] = trip.attribute("href").value
      trips << trips_hash
    end

    binding.pry
  end

end