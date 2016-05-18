require 'sidekiq/web'
Rails.application.routes.draw do
  post 'users', to: 'users#create'
  post 'users/sign_in', to: 'sessions#create'

  post 'users/password', to: 'passwords#send_reset_token'
  put 'users/password', to: 'passwords#reset_with_token'
  put 'users/:id/change_password', to: 'passwords#change_password'

  post 'users/confirmation', to: 'confirmations#create'
  put 'users/:user_id/update_email', to: 'users#update_email'

  resources :movies,
    only: [:index, :show, :delete],
    controller: 'movies'
  get 'recommend/recommend_by_similarity/:id', to: 'movies#recommend_by_similarity'
  get 'recommend/recommend_by_prediction', to: 'movies#recommend_by_prediction'
  post 'recommend/generate_similarities', to: 'movies#generate_similarities'
  post 'movies/update_info', to: 'movies#update_info'
  delete 'movies/delete_describers/:id', to: 'movies#delete_describers'
  post 'movies/generate_describers', to: 'movies#generate_describers'
  post 'movies/add_describers_to_matrix', to: 'movies#add_describers_to_matrix'

  get 'ratings/user_ratings/:id', to: 'ratings#user_ratings'
  get 'ratings/movie_ratings/:id', to: 'ratings#movie_ratings'
  get 'ratings/best_ratings/', to: 'ratings#best_ratings'
  delete 'ratings/:id', to: 'ratings#destroy'
  delete 'ratings/destroy_cold_start/:id', to: 'ratings#destroy_cold_start'

  mount Sidekiq::Web, at: '/process/show_process'
end
