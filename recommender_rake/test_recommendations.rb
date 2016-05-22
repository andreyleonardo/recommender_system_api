deleted_movies = File.open('deleted_movies.txt')
processed_movies = File.new('processed_movies.txt')
recommender = MovieRecommender.new
while (line = deleted_movies.gets)
  line = line.split(';')
  user_id = line[line.index('user_id') + 1]
  movie_id = line[line.index('movie_id') + 1]
  movies = recommender.predictions_for(user_id, matrix_label: :users, with_scores: true).to_h
  recommendation_info = "before describers:\n movie:#{movie_id},position:#{movies.keys.index('movie_id')},score:#{movies[movie_id]}\n"
  movie = Movie.find(movie_id)
  DescribersProcessor.create_describers_for movie
  recommender.add_describers_to_matrix movie_id
  movies = recommender.predictions_for(user_id, matrix_label: :users, with_scores: true).to_h
  recommendation_info = "after describers\n movie:#{movie_id},position:#{movies.keys.index('movie_id')},score:#{movies[movie_id]}\n"
  processed_movies.write recommendation_info
end
processed_movies.close
