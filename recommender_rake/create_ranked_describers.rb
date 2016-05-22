MovieDescriber.delete_all
Describer.delete_all

Movie.find_each do |movie|
  next unless movie.describers.empty?
  DescribersProcessor.create_describers_for movie, false
end
