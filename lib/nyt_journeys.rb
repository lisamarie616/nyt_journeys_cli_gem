require 'open-uri'
require 'pry'
require 'nokogiri'

module NytJourneys
end

require_relative "nyt_journeys/command_line_interface.rb"
require_relative "nyt_journeys/data_generator.rb"
require_relative "nyt_journeys/journeys.rb"
require_relative "nyt_journeys/scraper.rb"
require_relative "nyt_journeys/version.rb"