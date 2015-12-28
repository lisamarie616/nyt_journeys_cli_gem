class NytJourneys::Data_Generator
  BASE_URL = "http://www.nytimes.com/times-journeys/trip-type/"

  # def self.populate
  #   make_journeys
  # end

  def make_journeys
    type_array = NytJourneys::Scraper.scrape_type_summary_page(BASE_URL)
    
    trip_array = []
    type_array.each do |type|
      trips = NytJourneys::Scraper.scrape_type_detail_page(type[:type_url])
      trip_array << trips
    end
    trip_array.flatten!
    
    NytJourneys::Journeys.create_from_collection(trip_array)
  end


end