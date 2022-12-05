class CreateBooksUploads < ActiveRecord::Migration[7.0]
  def change
    create_table :books_uploads do |t|
      t.text :original_filename
      t.text :unique_filename
      t.text :url
      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
