deleted_movies = File.open('deleted_movies.txt')
recommender = MovieRecommender.new
while (line = deleted_movies.gets)
  line = line.split(';')
  movie_id = line[line.index('movie_id') + 1]
  recommender.create_cold_start_item movie_id
  puts movie_id
end
