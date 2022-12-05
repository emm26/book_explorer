class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.text :title
      t.text :author
      t.text :custom_id
      t.datetime :date_published
      t.text :publisher_name
      t.timestamps
      t.references :books_upload, index: true
    end
  end
end
