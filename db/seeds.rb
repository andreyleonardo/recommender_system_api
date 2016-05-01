require 'csv'

UserRating.delete_all
Tag.delete_all
Rating.delete_all
Link.delete_all

puts 'Creating links'
start = Time.zone.now
# load link data
csv_text = File.read('db/seeds_data/links.csv')
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  link = row.to_hash
  movie = Movie.find_by(movielens_id: link['movieId'])
  next unless movie
  Link.create(
    movie_id: movie.id,
    imdb_id: "tt#{link['imdbId']}",
    tmdb_id: link['tmdbId']
  )
end
puts Time.zone.now - start


puts 'Creating ratings'
start = Time.zone.now
# load rating data
csv_text = File.read('db/seeds_data/ratings.csv')
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  rating = row.to_hash
  movie = Movie.find_by(movielens_id: rating['movieId'])
  next unless movie
  Rating.create(
    user_id: rating['userId'],
    movie_id: movie.id,
    rating: rating['rating']
  )
  UserRating.create(
    user_id: rating['userId'],
    rating_id: Rating.last.id
  )
end
puts Time.zone.now - start


puts 'Creating tags'
start = Time.zone.now
# load tags data
csv_text = File.read('db/seeds_data/tags.csv')
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  tag = row.to_hash
  movie = Movie.find_by(movielens_id: tag['movieId'])
  next unless movie
  Tag.create(
    user_id: tag['userId'],
    movie_id: movie.id,
    tag: tag['tag']
  )
end
puts Time.zone.now - start
