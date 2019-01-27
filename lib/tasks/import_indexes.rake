namespace :elastic do
  desc 'Import indexes'
  task :import_indexes => :environment do
    puts 'Imorting...'
    User.import(query: -> { includes(ascents: :line) }, force: true)
    City.import(query: -> { includes(:zips) }, force: true)
  end
end
