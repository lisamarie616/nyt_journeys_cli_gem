class NytJourneys::CommandLineInterface
  def call
    NytJourneys::Data_Generator.new.make_journeys
    start
  end

  def list
    puts ""
    puts "~~*~~*~~*~~ Available New York Times Journeys ~~*~~*~~*~~"
    puts ""
    NytJourneys::Journeys.all.each.with_index(1) do |journey, index|
      puts "#{index}. #{journey.name}"
    end
    puts ""
  end

  def print_journey(journey)
    puts ""
    puts "~~*~~*~~*~~ #{journey.name} ~~*~~*~~*~~"
    puts "A Journey Focused On #{journey.type}"
    puts ""
    puts journey.description
    puts ""
    puts "From: #{journey.cost}"
    puts ""
    puts "Journey Duration: #{journey.length}"
    puts ""
    puts "Available Dates:"
    puts journey.dates
    puts ""
    puts "Itinerary:"
    puts journey.itinerary
    puts ""
  end

  def start
    list
    input = nil
    while input != "exit"
      puts ""
      puts "Which journey would you like to learn more about? Enter 1 - #{NytJourneys::Journeys.all.count}."
      puts ""
      puts "Enter 'list' to see the journeys again."
      puts "Enter 'exit' to end the program."
      puts ""
      input = gets.strip
      if input == "list"
        list
      elsif input.to_i > 0
        if journey = NytJourneys::Journeys.find(input.to_i)
          print_journey(journey)
        end
      end
    end
    puts ""
    puts NytJourneys::Scraper.scrape_quotes.sample
    puts ""
    puts "Enjoy the journey!"
  end

end