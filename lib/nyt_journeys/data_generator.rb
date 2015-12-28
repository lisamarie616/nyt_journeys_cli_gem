class NytJourneys::Data_Generator
  BASE_URL = "http://www.nytimes.com/times-journeys/trip-type/"

  def make_journeys
    type_array = NytJourneys::Scraper.scrape_type_summary_page(BASE_URL)

    trip_array = type_array.collect do |type|
      NytJourneys::Scraper.scrape_type_detail_page(type)
    end
    trip_array.flatten!

    NytJourneys::Journeys.create_from_collection(trip_array)
    binding.pry
  end
  
end