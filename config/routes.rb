Rails.application.routes.draw do

  root 'books#featured'

  get 'books', to: 'books#index'

  get 'books/:id', to: 'books#show', as: 'book'

  devise_for :users, controllers: {
    omniauth_callbacks: 'auth/callbacks'
  }

end
