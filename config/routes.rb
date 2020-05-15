Rails.application.routes.draw do
  root 'static_pages#index'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/index', to: 'static_pages#index'
  get '/home', to: 'static_pages#home'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  get 'users/:id/orders' => 'users#orders', :as => :user_orders
  resources :account_activations, only: [:edit]
  resources :password_resets, only: %i[new create edit update]
  resources :categories
  resources :orders
  resources :proposals, only: %i[create destroy update]
end
