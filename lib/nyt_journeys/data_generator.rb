class NytJourneys::Data_Generator
  BASE_URL = "http://www.nytimes.com/times-journeys/trip-type/"

  def make_journeys
    type_array = NytJourneys::Scraper.scrape_type_summary_page(BASE_URL)

    trip_array = type_array.collect do |type|
      NytJourneys::Scraper.scrape_type_detail_page(type[:type_url])
    end
    trip_array.flatten!
    NytJourneys::Journeys.create_from_collection(trip_array)
  end

  # description: trip_details.css("div.trip-description p")
  # cost: trip_details.css("div.price p").text
  # length: trip_details.css("div.itinerary-info > p").text
  # dates: div.departures a.departure-link
  # itinerary: div.primary-information, div.day-number, h3.day-title
  


  # def self.scrape_trip_page(trip_url)
  #   trip_details = Nokogiri::HTML(open(trip_url))
  #   trip = {}

  #   trip[:description] = ""
  #   trip_details.css("div.trip-description p").each do |paragraph|
  #     trip[:description] << "#{paragraph.text} "
  #   end
  #   trip[:description].strip!.gsub!(/(\n)/," ")

  #   trip[:cost] = trip_details.css("div.price p").text[/(\d|,)+/].gsub(",","").to_i
  #   trip[:length] = trip_details.css("div.itinerary-info > p").text.strip[/.+s/]

  #   trip[:dates] = []
  #   trip_details.css("div.departures a.departure-link").each do |dates|
  #     trip[:dates] << dates.text
  #   end

  #   trip[:itinerary] = []
  #   trip_details.css("div.primary-information").each do |day|
  #     trip[:itinerary] << "#{day.css("div.day-number").text} - #{day.css("h3.day-title").text}"
  #   end
  #   trip  # hash with trip attributes
  # end

end