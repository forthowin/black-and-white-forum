Rails.application.routes.draw do
  root 'static_pages#front'

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:create]
  get '/forum', to: 'topics#index'
  get '/forum/:topic_id/threads', to: 'threads#index', as: :forum_threads
  get '/forum/:topic_id/new', to: 'threads#new', as: :new_thread
  post '/forum/:topic_id/create', to: 'threads#create', as: :create_thread
  get '/forum/:topic_id/thread/:thread_id', to: 'threads#show', as: :forum_thread
  resources :posts, only: :create
end
