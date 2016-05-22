Movie.find_each do |movie|
  next unless movie.describers.empty?
  DescribersProcessor.create_describers_for movie, false
  recommender = MovieRecommender.new
  recommender.add_describers_to_matrix movie.id
  puts movie.id
end
