require 'nokogiri'
require 'open-uri'

module PZA
  module FetchAscents
    PAGES = 716
    URL = "http://ranking.pza.org.pl/ostatnie-przejscia"

    def self.fetch_all_and_insert_to_database
      (1..PAGES).each do |page_number|
        page_ascents = fetch_ascents_from_page(page_number)
        fill_database(page_ascents)
      end
    end

    def self.fetch_ascents_from_page(page_number)
      url = URL + "?page=#{page_number}"
      Nokogiri::HTML(open(url)).css('tr')
    end

    def self.fill_database(page_ascents)
      page_ascents.each do |row|
        next if row.css('td').size != 10
        user = fetch_or_create_user(row)
        line = fetch_or_create_line(row)
        ascent_params = ascent_params(row, user.id, line)
        Ascent.create!(ascent_params)
      end
    end

    def self.fetch_or_create_user(row)
      user_params = user_params(row)
      user = User.where(user_params).first
      user.nil? ? User.create!(user_params) : user
    end

    def self.fetch_or_create_line(row)
      line_params = line_params(row)
      line = Line.where(line_params).first
      line.nil? ? Line.create!(line_params) : line
    end

    def self.user_params(row)
      name, surname = row.css('td.username').text.strip.split
      {
        name:    name,
        surname: surname
      }
    end

    def self.line_params(row)
      grade = row.css('td.grade').text.strip
      {
        name:  row.css('td.route-name').text.strip.downcase.capitalize,
        grade: grade == "" ? row.css('td.prop_triangle a').text.strip.downcase : grade,
        crag:  row.css('td.trim')[1].text.strip.downcase.capitalize,
        kind:  row.css('td.scores')[0].text.strip.downcase
      }
    end

    def self.ascent_params(row, user_id, line)
      {
        user_id:  user_id,
        line_id:  line.id,
        style:    row.css('td[data-name=style]').text.strip.downcase,
        date:     Date.parse(row.css('td.date').text.strip),
        kind:     line.kind,
        belayer:  row.css('i')[0].class == NilClass ? "" : row.css('i')[0]['data-content']
      }
    end
  end
end
