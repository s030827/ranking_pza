namespace :ranking do
  desc 'Random zips for users'
  task :random_zips => :environment do
    puts 'Loading...'
    index = 0
    User.all.each do |u|
      zip = City.all[index].zips.first
      u.update_attributes(
        lat: zip.lat, lng: zip.lng, email: "user_#{index}@elo.com", zip: zip.code
      )
      index += 1
    end
  end
end
