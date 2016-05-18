class MoviesController < ApplicationController
  skip_before_action :authenticate_request
  def index
    movies = Movie.all.limit(100).order(id: :asc)
    render json: movies, root: false
  end

  def show
    movie = Movie.find params[:id]
    render json: movie, root: false
  end

  def recommend_by_similarity
    recommender = MovieRecommender.new
    movies = recommender.similarities_for(params[:id], with_scores: true)
    movies_hash = movies.to_h
    ids = movies_hash.keys
    movies = Movie.where(id: ids).order("position(id::text in '#{ids.join(',')}')")
    movies.each do |movie|
      movie.score = movies_hash[movie.id.to_s]
    end

    movies = movies.sort do |movie_a, movie_b|
      movie_b.score <=> movie_a.score
    end

    movies.each_with_index do |movie, index|
      movie.rank = index + 1
    end

    render json: movies
  end

  def recommend_by_prediction
    recommender = MovieRecommender.new
    movies = recommender.predictions_for(item_set: params[:movies_id], with_scores: true, limit: 100) \
      if params[:movies_id]
    movies = recommender.predictions_for(params[:user_id], matrix_label: :users, with_scores: true, limit: 100) \
      if params[:user_id]
    movies_hash = movies.to_h
    ids = movies_hash.keys
    movies = Movie.where(id: ids).order("position(id::text in '#{ids.join(',')}')")
    movies.each do |movie|
      movie.score = movies_hash[movie.id.to_s]
    end

    movies = movies.sort do |movie_a, movie_b|
      movie_b.score <=> movie_a.score
    end

    movies.each_with_index do |movie, index|
      movie.rank = index + 1
    end

    render json: movies
  end

  def generate_similarities
    RecommenderProcessWorker.perform_async
    render json: 'Process Started', status: 200
  end

  def update_info
    Movie.update_info_from_api false
    render json: 'Process Started', status: 200
  end

  def delete_describers
    movie = Movie.find(params[:id])
    movie.delete_describers_from_matrix
  end

  def generate_describers
    GenerateDescriberWorker.perform_async
    render json: 'Process Started', status: 200
  end

  def add_describers_to_matrix
    AddDescriberWorker.perform_async params[:movie_id]
    render json: 'Process Started', status: 200
  end

  private

  def movie_params
    params.require(:movie).permit(
      :name
    )
  end
end
