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
    movies_hash = movies.to_h
    ids = movies_hash.keys
    movies = Movie.where(id: ids).order("position(id::text in '#{ids.join(',')}')")
    # movies = Movie.where(id: ids).order("position(','||id::text||',' in '#{ids.join(',')}')")
    # movies = Movie.where(id: ids).order("idx(array[#{ids.join(',')}], id")
    # movies = Movie.find(movies_hash.keys)
    movies.each do |movie|
      movie.score = movies_hash[movie.id.to_s]
    end

    movies = movies.sort do |movie_a, movie_b|
      movie_b.score <=> movie_a.score
    end

    render json: movies, root: false
  end

  def recommend_movies_by_prediction
    recommender = MovieRecommender.new
    movies = recommender.predictions_for(item_set: params[:movies_id]) if params[:movies_id]
    movies = recommender.predictions_for(params[:user_id], matrix_label: :users) if params[:user_id]
    movies = Movie.where(id: movies).order("position(id::text in '#{movies.join(',')}')")
    # movies = Movie.where(id: movies).order("idx(array[#{movies.join(',')}], id")
    # movies = Movie.where(id: movies).order("position(','||id::text||',' in '#{movies.join(',')}')")
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
