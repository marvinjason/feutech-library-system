Rails.application.routes.draw do

  root 'pages#home'

  resources :comments
  
  resources :reviews
  
  resources :reservations
  
  resources :authors
  
  resources :books
  
  resources :publishers
  
  resources :users

  devise_for :users, controllers: {
    omniauth_callbacks: 'auth/callbacks'
  }

end
