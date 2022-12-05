Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/', to: 'books#upload_page', as: 'root'
  get 'books/upload', to: 'books#upload_page'
  post 'books/upload_csv'
  get 'books/my_uploads', to: 'books#my_uploads'
  get 'uploads/:id/books', to: 'books#list_upload_books'
end
