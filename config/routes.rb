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
    only: [:index, :show],
    controller: 'movies' do
      get 'recommend_by_similarity', to: 'movies#recommend_by_similarity'
    end
  get 'movies/recommend_by_prediction', to: 'movies#recommend_by_prediction'
  get 'movies/generate_similarities', to: 'movies#generate_similarities'
  get 'movies/update_info', to: 'movies#update_info'

  mount Sidekiq::Web, at: '/process/show_process'
end
