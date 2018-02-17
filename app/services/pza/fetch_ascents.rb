require 'nokogiri'
require 'open-uri'

module PZA
  module FetchAscents
    PAGES = 716
    URL = "http://ranking.pza.org.pl/ostatnie-przejscia"

    def fetch_all_and_insert_to_database
      (1..PAGES).each do |page_number|
        page_ascents = fetch_ascents_from_page(page_number)
        fill_database(page_ascents)
      end
    end

    def fetch_ascents_from_page(page_number)
      url = URL + "?page=#{page}"
      Nokogiri::HTML(open(url)).css('tr')
    end

    def fill_database(page_ascents)
      page_ascents.each do |row|
        next if row.css('td').size != 10
        user = fetch_or_create_user(row)
        line = fetch_or_create_line(row)
        ascent_params = ascent_params(row, user.id, line.id)
        Ascent.create!(ascent_params)
      end
    end

    def fetch_or_create_user(row)
      user_params = user_params(row)
      user = User.where(user_params).first
      user.nil? ? User.create!(user_params) : user
    end

    def fetch_or_create_line(row)
      line_params = line_params(row)
      line = Line.where(line_params).first
      line.nil? ? Line.create!(line_params) : line
    end

    def user_params(row)
      name, surname = row.css('td.username').text.strip.split
      {
        name:    name,
        surname: surname
      }
    end

    def line_params(row)
      {
        name:  row.css('td.route-name').text.strip,
        grade: row.css('td.grade').text.strip,
        crag:  row.css('td.trim')[1].text.strip,
        type:  row.css('td.scores')[0].text.strip
      }
    end

    def ascent_params(row, user_id, line_id)
      {
        user_id:  user_id,
        line_id:  line_id,
        style:    row.css('td[data-name=style]'),
        date:     Date.parse(row.css('td.date').text.strip),
        belayer:  row.css('i')[0].class == NilClass ?
          "" : row.css('i')[0]['data-content']
      }
    end
  end
end
