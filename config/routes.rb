Rails.application.routes.draw do
  get 'session/new'


  get 'session/create'


  get 'session/destroy'

  root 'welcome#index'
  resources :tracks
  resources :users do
    resources :ratings, only: [:edit, :create, :update, :destroy]
  end

  post '/users/:id/tracks', to: 'users#add_track'
  delete '/users/:id/tracks/:track_id', to: 'users#delete_track'
  post '/tracks/:id/users', to: 'tracks#add_user'
  delete '/tracks/:id/users/:user_id', to: 'tracks#delete_user'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
