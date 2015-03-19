Rails.application.routes.draw do
  root 'static_pages#front'

  get '/register', to: 'users#new'
  get '/forum', to: 'topics#index'

  resources :users, only: [:create]
end
