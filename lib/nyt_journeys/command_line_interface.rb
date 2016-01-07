class NytJourneys::CommandLineInterface
  attr_accessor :input

  def call
    NytJourneys::Data_Generator.new.make_journeys
    greeting
    start
  end

  def greeting
    puts ""
    puts "~~*~~*~~*~~ New York Times Journeys ~~*~~*~~*~~"
    puts ""
    puts NytJourneys::Scraper.scrape_quotes.sample
    puts ""
  end

  def list_journeys
    puts ""
    puts "~~*~~*~~*~~ Available New York Times Journeys ~~*~~*~~*~~"
    puts ""
    NytJourneys::Journeys.all.each.with_index(1) do |journey, index|
      puts "#{index}. #{journey.name}"
    end
    puts ""
  end

  def navigate_journeys
    list_journeys
    puts ""
    puts "Which journey would you like to learn more about? Enter 1 - #{NytJourneys::Journeys.all.count}."
    puts ""
    puts "Enter 'types' to see journey categories."
    puts "Enter 'exit' to end the program."
    self.input = gets.downcase.strip
    if self.input == "types"
      navigate_types
    elsif self.input.to_i > 0
      if journey = NytJourneys::Journeys.find(self.input.to_i)
        print_journey(journey)
      end
    end
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

  def list_types
    puts ""
    puts "~~*~~*~~*~~ Journeys Focused On ~~*~~*~~*~~"
    puts ""
    NytJourneys::Journeys.types.each.with_index(1) do |type, index|
      puts "#{index}. #{type}"
    end
    puts ""
  end

  def navigate_types
    list_types
    puts ""
    puts "Which type of journey would you like to take? Enter 1 - #{NytJourneys::Journeys.types.count}."
    puts ""
    puts "Enter 'list' to see all journeys."
    puts "Enter 'exit' to end the program."
    self.input = gets.downcase.strip
    if self.input == "list"
      navigate_journeys
    elsif self.input.to_i > 0
      if category = NytJourneys::Journeys.types[self.input.to_i - 1]
        print_category(category)
        navigate_category(category)
      end
    end
  end

  def print_category(category)
    puts ""
    puts "~~*~~*~~*~~ Journeys Focused On #{category} ~~*~~*~~*~~"
    puts ""
    NytJourneys::Journeys.find_by_type(category).each.with_index(1) do |journey, index|
      puts "#{index}. #{journey.name}"
    end
    puts ""
  end

  def navigate_category(category)
    puts ""
    puts "Which journey would you like to learn more about? Enter 1 - #{NytJourneys::Journeys.find_by_type(category).count}."
    puts ""
    puts "Enter 'list' to see all journeys."
    puts "Enter 'types' to see journey categories."
    puts "Enter 'exit' to end the program."
    self.input = gets.downcase.strip
    if self.input == "list"
      navigate_journeys
    elsif self.input == "types"
      navigate_types
    elsif self.input.to_i > 0
      if journey = NytJourneys::Journeys.find_by_type(category)[self.input.to_i - 1]
        print_journey(journey)
      end
    end
  end

  def start
    self.input = nil
    while self.input != "exit"
      puts ""
      puts "Enter 'list' to see all journeys."
      puts "Enter 'types' to see journey categories."
      puts "Enter 'exit' to end the program."
      puts ""
      self.input = gets.downcase.strip
      if self.input == "list"
        navigate_journeys
      elsif self.input == "types"
        navigate_types
      end
    end
    puts ""
    puts NytJourneys::Scraper.scrape_quotes.sample
    puts ""
    puts "Enjoy the journey!"
  end
end