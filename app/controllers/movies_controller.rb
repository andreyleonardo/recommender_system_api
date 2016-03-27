class MoviesController < ApplicationController
  skip_before_action :authenticate_request
  def index
    movies = Movie.all.limit(100)
    render json: movies, root: false
  end

  def show
    movie = Movie.find params[:id]
    render json: movie, root: false
  end

  def recommend_movies_by_similarity
    recommender = MovieRecommender.new
    movies = recommender.similarities_for(params[:id], with_scores: true)
    # movies_hash = movies.to_h
    # movies = Movie.find(movies_hash.keys)
    # movies.each do |movie|
    #   movie.score = movies_hash[movie.id.to_s]
    # end

    render json: movies, root: false
  end

  def recommend_movies_by_prediction
    recommender = MovieRecommender.new
    movies = recommender.predictions_for(item_set: params[:movies_id])
    movies = Movie.find(movies)
    render json: movies, root: false
  end

  def generate_similarities
    RecommenderProcessWorker.perform_async
  end

  private

  def movie_params
    params.require(:movie).permit(
      :name
    )
  end
end
