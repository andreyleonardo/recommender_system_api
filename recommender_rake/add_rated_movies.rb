deleted_movies = File.open('deleted_movies.txt')
recommender = MovieRecommenderFinal.new
while (line = deleted_movies.gets)
  line = line.split(';')
  movie_id = line[line.index('movie_id') + 1]
  user_id = line[line.index('user_id') + 1]
  recommender.add_describers_to_matrix movie_id
  recommender.add_user_movie_to_matrix user_id, movie_id
  puts movie_id
end
