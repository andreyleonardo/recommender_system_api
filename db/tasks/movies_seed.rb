require 'csv'

Movie.delete_all
LIMIT = 1000
puts 'Creating movies'
start = Time.zone.now
# load genre and movie data
csv_text = File.read('db/seeds_data/movies.csv')
csv = CSV.parse(csv_text, headers: true)
csv.each_with_index do |row, index|
  break if index > LIMIT
  movie = row.to_hash
  Movie.create(
    id: movie['movieId'],
    title: movie['title']
  )
end
puts Time.zone.now - start
