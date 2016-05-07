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
  movie_saved = Movie.find_by(id: movie['movieId'])
  genres = movie['genres'].split('|')
  genres.each do |g|
    genre = Genre.find_by(name: g)
    if genre.nil?
      genre = Genre.create(
        name: g
      )
    end
    MovieGenre.create(
      movie_id: movie_saved.id,
      genre_id: genre.id
    ) unless movie_saved.nil?
  end
end
puts Time.zone.now - start
