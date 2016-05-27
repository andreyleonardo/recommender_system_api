recommender = MovieRecommenderFinal.new
Movie.find_each do |movie|
  next if movie.describers.empty?
  recommender.delete_describers_from_matrix movie.id
  movie.describers.delete_all
  puts movie.id
end
