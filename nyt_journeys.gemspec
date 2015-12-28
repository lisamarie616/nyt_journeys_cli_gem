# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nyt_journeys/version'

Gem::Specification.new do |spec|
  spec.name          = "nyt_journeys"
  spec.version       = NytJourneys::VERSION
  spec.authors       = ["lisamarie616"]
  spec.email         = ["lisamarie616@gmail.com"]

  spec.summary       = %q{NYT Journeys}
  spec.description   = %q{Explore journeys available with NY Times.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($\)
  spec.executables   = ["now-playing"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib", "lib/nyt_journeys"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "pry"
end