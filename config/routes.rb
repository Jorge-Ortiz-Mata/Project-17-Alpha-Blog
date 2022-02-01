Rails.application.routes.draw do

  root 'pages#home'

  resources :articles

  # get  'articles',            to: 'articles#index'
  # get  'articles/new',        to: 'articles#new'
  # get  'articles/:id',        to: 'articles#show'
  # post 'articles',            to: 'articles#create'
  # get  'articles/:id/edit',   to: 'articles#edit'
  # put  'articles/:id',        to: 'articles#update'

  resources :users, except: [:new]
  get 'signup', to: 'users#new'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get "logout", to: "sessions#destroy"



end
