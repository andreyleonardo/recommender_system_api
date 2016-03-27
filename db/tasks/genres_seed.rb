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
  saved_movie = Movie.find_by(movielens_id: movie['movieId'])
  next unless saved_movie
  genres = movie['genres'].split('|')
  genres.each do |g|
    genre = Genre.find_by(name: g)
    if genre
      MovieGenre.create(
        movie_id: saved_movie.id,
        genre_id: genre.id
      )
    else
      Genre.create(
        name: g
      )
      genre = Genre.find_by(name: g)
      MovieGenre.create(
        movie_id: saved_movie.id,
        genre_id: genre.id
      )
    end
  end
end
puts Time.zone.now - start
