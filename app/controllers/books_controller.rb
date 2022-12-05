class BooksController < ApplicationController
  before_action :set_books_upload, :redirect_unless_book_uploader, only: :list_upload_books

  def upload_page; end

  def upload_csv
    books, errors = Book.books_from_csv(params['books_csv'])
    if errors.any?
      flash[:alert] = "<div>Failed to process file</div><ul class='list-disc' style='margin-left:3rem;'>#{errors.join}</ul>"
      return redirect_to '/books/upload'
    end

    Book.save_books!(books)
    books_upload = BooksUpload.new_from_file(file: params['books_csv'], user_id: current_user.id)
    books_upload.books = books
    books_upload.save!
    flash[:success] = 'Successful upload'
    redirect_to "/uploads/#{books_upload.id}/books"
  end

  def my_uploads
    @book_uploads = BooksUpload.where(user_id: current_user.id)
  end

  def list_upload_books
    @books = @books_upload.books
  end

  private

  def set_books_upload
    @books_upload = BooksUpload.find(params['id'])
  end

  def redirect_unless_book_uploader
    redirect_to '/' unless @books_upload.user_id == current_user.id
  end
end
