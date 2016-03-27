require 'csv'

Movie.delete_all

puts 'Creating movies'
start = Time.zone.now
# load genre and movie data
csv_text = File.read('db/seeds_data/movies.csv')
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  movie = row.to_hash
  Movie.create(
    title: movie['title']
  )
end
puts Time.zone.now - start
