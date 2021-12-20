Rails.application.routes.draw do
  resources :tags
  
  resources :books
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "books#menu"
  get 'books#index', to: 'books#index'
end
