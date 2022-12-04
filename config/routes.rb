Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get '/', to: 'books#upload', as: 'root'
  get 'books/upload'
  # Defines the root path route ("/")
  # root "articles#index"
end
