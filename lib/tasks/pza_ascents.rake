namespace :pza do
  desc 'Fetch all ascents from PZA ranking page'
  task :fetch_all_ascents => :environment do
    puts 'Loading...'
    PZA::FetchAscents.fetch_all_and_insert_to_database
  end

  desc 'Add points to every ascent in the database'
  task :add_points => :environment do
    puts 'Adding points...'
    ascents = Ascent.all
    ascents.each do |ascent|
      ascent.update_attribute(:points, PZA::CalculatePoints.new(ascent).call)
    end
  end
end
