Rails.application.routes.draw do
  root 'static_pages#front'

  get '/register', to: 'users#new'

  resources :users, only: [:create]
end
