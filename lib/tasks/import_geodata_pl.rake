namespace :ranking do
  desc 'import geo data for PL'
  task import_geo_data_pl: [:environment] do
    country = Country.find_by(iso: 'PL')
    filename = "#{Rails.root}/lib/assets/PL.txt"

    File.open(filename, 'r').each do |row|
      place = row.split("\t")
      city = City.where(name: place[2]).first_or_create do |city|
        puts "Creating city (#{place[2]})"
        city.country_id = country.id
      end

      create_zip(city, place)
    end
  end
end

def create_zip(city, place)
  code = place[1]
  zip = Zip.find_by(code: code)
  unless zip
    lat = place[9]
    lng = place[10]
    puts "Creating zip: #{code}, with #{lat}, #{lng} in #{city.name}"
    zip = city.zips.create(code: code, lat: lat, lng: lng)
  end
  return if zip.cities.include?(city)
  zip.cities << city
  zip.save
end
