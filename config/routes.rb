Rails.application.routes.draw do

  root 'books#featured'

  get 'books', to: 'books#index'

  get 'books/:id', to: 'books#show', as: 'book'

  post 'books/:id', to: 'books#reserve'

  get 'authors/:id', to: 'authors#show', as: 'author'

  devise_for :users, controllers: {
    omniauth_callbacks: 'auth/callbacks'
  }

end
