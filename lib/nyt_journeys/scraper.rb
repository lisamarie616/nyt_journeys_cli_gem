class NytJourneys::Scraper
  
  # type_name: .css("h3.trip-type-list-title").text
  # type_url: .css("a.view-all-link").attribute("href").value
  def self.scrape_type_summary_page(summary_url)
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
  def self.scrape_type_detail_page(types_hash)
    type_details = Nokogiri::HTML(open(types_hash.values[1]))
    trips =[]
    type_details.css("li.journey-list-item > a").each do |trip|
      trips_hash = {}
      trips_hash[:name] = trip.css("h2.item-title").text
      trips_hash[:url] = trip.attribute("href").value
      trips_hash[:type] = types_hash.values[0]
      trips << trips_hash
    end
    trips  # an array of trip hashes with name, url, and type properties
  end

  #  quote: quotations_page.css("dt.quote"), .css("a").text
  #  author: quotations_page.css("dd.author), .css("a").text
  def self.scrape_quotes(quotes_url="http://www.quotationspage.com/search.php3?homesearch=journey&page=1")
    quotations_page = Nokogiri::HTML(open(quotes_url))
    quotes = []
    quotations_page.css("dt.quote").each do |quote|
      item = "#{quote.css("a").text}"
      quotes << item
    end
    authors = []
    quotations_page.css("dd.author").each do |author|
       item = "#{author.css("a")[4].text}"
       authors << item
    end
    quotes.map.with_index do |quote, index|
      "#{quote} ~ #{authors[index]}"
    end
  end

end