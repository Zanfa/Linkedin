require 'open-uri'

class ProfileScraper

  def find(first_name, last_name, headline)
    @first_name = first_name
    @last_name = last_name
    @headline = headline

    search_url = "http://www.linkedin.com/pub/dir/?first=#{first_name.gsub(' ', '+')}&last=#{last_name.gsub(' ', '+')}&search=Search"

    puts "Pulling #{search_url}"

    doc = Nokogiri::HTML(open(search_url), 'User-Agent' => 'Mozilla/5.0 (Windows NT 6.2; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1667.0 Safari/537.36')
    if doc.css('#main.profile').first
      parse_profile(doc)
    elsif doc.css('#main.grid-e').first
      parse_search_results(doc)
    else
      nil # TODO: Better way to handle unknown content?
    end

  end

  def parse_profile(doc)
    puts 'Parsing profile'

    positions = []
    doc.css('#profile-experience .position').each do |position_div|
      title = position_div.at_css('h3').text.strip
      organization = position_div.at_css('h4').text.strip

      positions << {title: title, organization: organization}
    end

    positions
  end

  def parse_search_results(doc)
    puts 'Parsing search results'

    result = nil

    doc.css('li.vcard').each do |profile|
      first_name = profile.at_css('.given-name').text.strip
      last_name = profile.at_css('.family-name').text.strip
      headline = profile.at_css('.vcard-basic .title').text.strip

      if @first_name == first_name and
          @last_name == last_name and
          @headline == headline

        # We have a match, continue to profile
        link = profile.at_css('h2 a').attr('href')

        result = parse_profile Nokogiri::HTML(open(link, 'User-Agent' => 'Mozilla/5.0 (Windows NT 6.2; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1667.0 Safari/537.36'))

      end

    end

    result
  end

end