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

  def start
    list
    input = nil
    while input != "exit"
      puts ""
      puts "Which journey would you like to learn more about? Enter 1 - #{NytJourneys::Journeys.all.count}."
      puts ""
      puts "Enter 'list' to see the journeys again."
      puts "Enter 'types' to view categories and explore journeys that way."
      puts "Enter 'exit' to end the program."
      puts ""
      input = gets.strip
    end
    puts "goodbye"
  end

end