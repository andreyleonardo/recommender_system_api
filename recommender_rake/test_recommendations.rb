deleted_movies = File.open('deleted_movies.txt')
processed_movies = File.new('processed_movies.txt', 'w')
recommender = MovieRecommender.new
processed_movies.write "Movie ID;Position Before;Score Before;Position After;Score After;Position Increase;Score Increase\n"
while (line = deleted_movies.gets)
  line = line.split(';')
  user_id = line[line.index('user_id') + 1]
  movie_id = line[line.index('movie_id') + 1]
  movies = recommender.predictions_for(user_id, matrix_label: :users, with_scores: true).to_h
  puts movies.keys
  score_before = movies[movie_id]
  position_before = movies.keys.index(movie_id)
  processed_movies.write "#{movie_id};#{position_before};#{score_before};"
  movie = Movie.find(movie_id)
  DescribersProcessor.create_describers_for movie, false
  recommender.add_describers_to_matrix movie_id
  movies = recommender.predictions_for(user_id, matrix_label: :users, with_scores: true).to_h
  score_after = movies[movie_id]
  position_after = movies.keys.index(movie_id)
  processed_movies.write "#{position_after};#{score_after};"
  processed_movies.write "#{position_after - position_before};#{score_after - score_before}\n"
end
processed_movies.close
