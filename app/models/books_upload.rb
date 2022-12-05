class BooksUpload < ApplicationRecord
  has_many :books
  BOOK_UPLOADS_BUCKET = ENV['CSV_BOOK_UPLOADS_BUCKET']

  def self.new_from_file(file:, user_id:)
    book_upload = new(
      original_filename: file.original_filename,
      unique_filename: unique_filename(file.original_filename),
      user_id: user_id
    )
    book_upload.save_to_s3(file_contents: file.read, key: book_upload.unique_filename)
    book_upload.url = "https://#{BOOK_UPLOADS_BUCKET}.s3.eu-west-2.amazonaws.com/#{book_upload.unique_filename}"
    book_upload.save
    book_upload
  end

  def self.unique_filename(original_filename)
    original_filename.gsub('.csv', "_#{SecureRandom.uuid}.csv")
  end

  def save_to_s3(file_contents:, key:)
    client = Aws::S3::Client.new
    client.put_object(
      bucket: BOOK_UPLOADS_BUCKET,
      key: key,
      body: file_contents
    )
  end
end
