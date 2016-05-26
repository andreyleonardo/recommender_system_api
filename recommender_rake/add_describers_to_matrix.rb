Movie.find_each do |movie|
  next unless movie.describers.empty?
  recommender = MovieRecommender.new
  recommender.add_describers_to_matrix movie.id
  puts movie.id
end
