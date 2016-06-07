deleted_movies = File.open('deleted_movies.txt')
recommender = MovieRecommender.new
while (line = deleted_movies.gets)
  line = line.split(';')
  movie_id = line[line.index('movie_id') + 1]
  user_id = line[line.index('user_id') + 1]
  recommender.delete_describers_from_matrix movie_id
  recommender.delete_movie_from_user user_id, movie_id
  puts movie_id
end
