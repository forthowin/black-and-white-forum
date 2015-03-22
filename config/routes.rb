Rails.application.routes.draw do
  root 'static_pages#front'

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:create]
  get '/forum', to: 'topics#index'
  get '/forum/:topic_id/subjects', to: 'subjects#index', as: :forum_subjects
  get '/forum/:topic_id/new', to: 'subjects#new', as: :new_subject
  post '/forum/:topic_id/create', to: 'subjects#create', as: :create_subject
  get '/forum/:topic_id/subject/:subject_id', to: 'subjects#show', as: :forum_subject
  resources :posts, only: :create
end
