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
    rating = Rating.find(params[:id])
    movie_id = rating.movie_id
    user_id = rating.user_id

    rating.delete

    UpdateMatrixWorker.perform_async(user_id, movie_id, true)
  end

  def destroy_cold_start
    # Rating.where(movie_id: params[:id]).delete_all
    UpdateMatrixWorker.perform_async(nil, nil, true)
  end
end
