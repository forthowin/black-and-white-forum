Rails.application.routes.draw do
  root 'static_pages#front'

  get '/register', to: 'users#new'
  get '/forum', to: 'topics#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:create]
end
