class RatingsController < ApplicationController
  skip_before_action :authenticate_request
  def user_ratings
    ratings = Rating.where(user_id: params[:id]).limit(100).order(rating: :desc)

    render json: ratings
  end

  def movie_ratings
    ratings = Rating.where(movie_id: params[:id]).order(rating: :desc)

    render json: ratings
  end

  def best_ratings
    rating_avg = Rating.average(:rating).to_f.round(1)
    ratings = Rating.find_best_ratings_by_user_id params[:user_id]
    ratings = Rating.where('movie_id = ? AND rating >= ?', params[:movie_id], rating_avg).group(:id, :movie_id)
                    .order(rating: :desc) if params[:movie_id]

    render json: ratings
  end

  def destroy
    CreateColdStartWorker.perform_async
  end
end
