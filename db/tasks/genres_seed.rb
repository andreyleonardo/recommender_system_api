require 'csv'

MovieGenre.delete_all
Genre.delete_all

puts 'Creating genres'
start = Time.zone.now
# load genre and movie data
csv_text = File.read('db/seeds_data/movies.csv')
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  movie = row.to_hash
  next unless Movie.find_by(id: movie['movieId'])
  genres = movie['genres'].split('|')
  genres.each do |g|
    genre = Genre.find_by(name: g)
    if genre
      MovieGenre.create(
        movie_id: movie['movieId'],
        genre_id: genre.id
      )
    else
      Genre.create(
        name: g
      )
      MovieGenre.create(
        movie_id: movie['movieId'],
        genre_id: Genre.last.id
      )
    end
  end
end
puts Time.zone.now - start
