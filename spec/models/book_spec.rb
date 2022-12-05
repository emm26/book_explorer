require "rails_helper"

RSpec.describe Book, type: :model do
  describe '.save_books' do
    it 'saves the given books' do
      one_book = Book.new(title: 'One book')
      another_book = Book.new(title: 'Another book')
      Book.save_books!([one_book, another_book])
      expect(Book.where(title: one_book.title)).not_to be_empty
      expect(Book.where(title: another_book.title)).not_to be_empty
    end
  end

  describe '.books_from_csv' do
    context 'books in the .csv already exist in the db (custom_id already exists)' do
      it 'returns no books and some error messages' do
        allow(Book).to receive(:where).and_call_original
        allow(Book).to receive(:where).with({custom_id: '978-0-123-49246-1'}).and_return([Book.new])
        books, errors = Book.books_from_csv(File.open('spec/support/csv_upload_samples/sample.csv'))
        expect(books).to be_empty
        expect(errors).not_to be_empty
      end
    end
    context 'books in the .csv are not in the db' do
      it 'returns books and no error messages' do
        books, errors = Book.books_from_csv(File.open('spec/support/csv_upload_samples/sample.csv'))
        expect(books).not_to be_empty
        expect(errors).to be_empty
      end
    end
  end
end
