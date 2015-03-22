Rails.application.routes.draw do
  root 'static_pages#front'

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:create]
  get '/forum', to: 'topics#index'
  get '/forum/:topic_id/threads', to: 'threads#index', as: :forum_threads
  get '/forum/:topic_id/thread/:thread_id', to: 'threads#show', as: :forum_thread
  post '/forum/:topic_id/threads/:thread_id/posts', to: 'posts#show'
  resources :posts, only: :create
end
