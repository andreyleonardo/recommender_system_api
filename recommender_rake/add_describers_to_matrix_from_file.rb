deleted_movies = File.open('deleted_movies.txt')
recommender = MovieRecommenderFinal.new
while (line = deleted_movies.gets)
  line = line.split(';')
  movie_id = line[line.index('movie_id') + 1]
  recommender.add_describers_to_matrix movie_id
  puts movie_id
end