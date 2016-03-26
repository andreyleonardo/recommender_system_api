# Predictor use 2 methods: similarities_for(:id) and find_predictions_for(item_set: [:ids])
# https://github.com/Pathgather/predictor
class MovieRecommender
  include Predictor::Base

  input_matrix :ratings, weight: 3.0
  input_matrix :tags, weight: 2.0
  input_matrix :describers, weight: 1.0, measure: :sorensen_coefficient # Use Sorenson over Jaccard
end

# recommender = MovieRecommender.new
# Movie.find_each do |movie|
#   if !movie.ratings.empty?
#     total_rating = 0
#     movie.ratings.map do |r|
#       total_rating += r.rating
#     end
#     total_rating /= movie.ratings.size
#     recommender.add_to_matrix(:ratings, total_rating, movie.id)
#   else
#     recommender.add_to_matrix(:ratings, 0, movie.id)
#   end
#   unless movie.tags.empty?
#     movie.tags.each do |t|
#       recommender.add_to_matrix(:tags, t.tag, movie.id)
#     end
#   end
#   recommender.add_to_matrix(:describers, movie.genres, movie.id)
# end
