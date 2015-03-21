Rails.application.routes.draw do
  root 'static_pages#front'

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:create]
  resources :topics, only: [:index] do
    resources :posts, only: [:index, :show]
  end
end
