Rails.application.routes.draw do

  root 'books#featured'

  get 'books', to: 'books#index'

  post 'books', to: 'books#index'

  get 'books/:id', to: 'books#show', as: 'book'

  post 'books/:id', to: 'books#reserve'

  post 'books/:id/review', to: 'books#review', as: 'review'

  post 'books/:id/comment', to: 'books#comment', as: 'comment'

  get 'authors/:id', to: 'authors#show', as: 'author'

  get 'dashboard', to: 'pages#dashboard', as: 'dashboard'

  get 'reservations', to: 'reservations#index', as: 'reservations'

  post 'reservations', to: 'reservations#index', as: 'search_reservations'

  post 'reservations/:id/approve', to: 'reservations#approve', as: 'approve'

  post 'reservations/:id/reject', to: 'reservations#reject', as: 'reject'

  devise_for :users, controllers: {
    omniauth_callbacks: 'auth/callbacks'
  }

  namespace :admin do
    resources :books
    resources :authors
    resources :publishers
    resources :users
  end

  post 'admin/books/search', as: 'search_books'

  post 'admin/authors/search', as: 'search_authors'

  post 'admin/publishers/search', as: 'search_publishers'

  post 'admin/users/search', as: 'search_users'

end
