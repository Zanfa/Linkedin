require './profile_scraper'
require 'nokogiri'
require 'open-uri'

scraper = ProfileScraper.new
result = scraper.find('James', 'Berdigans', 'Founder & CEO at ID-INFINITE')
puts result