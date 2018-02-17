desc 'Fetch ascents from PZA ranking page'
task :fetch_ascents => :environment do
  puts 'Loading...'
  PZA::FetchAscents.fetch_all_and_insert_to_database
end
