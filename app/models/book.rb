class Book < ApplicationRecord
  has_one :books_upload

  def self.save_books!(books)
    Book.transaction do
      books.each { |book| book.save! }
    end
  end

  def self.books_from_csv(csv)
    require 'csv'
    errors = []
    books = []

    CSV.foreach(csv) do |title, author, date_published, custom_id, publisher_name|
      errors << "<li>Book with ID: #{custom_id} already exists</li>" if Book.where(custom_id: custom_id).any?
      next if errors.any?

      books << Book.new(
        title: title,
        author: author,
        date_published: date_published,
        custom_id: custom_id,
        publisher_name: publisher_name
      )
    end

    [books, errors]
  end
end
