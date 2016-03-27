require 'sidekiq/web'
Rails.application.routes.draw do
  post 'users', to: 'users#create'
  post 'users/sign_in', to: 'sessions#create'

  post 'users/password', to: 'passwords#send_reset_token'
  put 'users/password', to: 'passwords#reset_with_token'
  put 'users/:id/change_password', to: 'passwords#change_password'

  post 'users/confirmation', to: 'confirmations#create'
  put 'users/:user_id/update_email', to: 'users#update_email'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  get 'list_movies', to: 'movies#index'
  get 'show_movie/:id', to: 'movies#show'
  get 'recommend/movies_by_similarity', to: 'movies#recommend_movies_by_similarity'
  get 'recommend/movies_by_prediction', to: 'movies#recommend_movies_by_prediction'
  post 'recommend/generate_similarities', to: 'movies#generate_similarities'
  mount Sidekiq::Web, at: '/sidekiq'
end
