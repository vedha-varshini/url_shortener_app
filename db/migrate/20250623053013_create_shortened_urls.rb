class CreateShortenedUrls < ActiveRecord::Migration[8.0]
  def change
    create_table :shortened_urls do |t|
      t.string :original_url
      t.string :short_code
      t.references :user, null: false, foreign_key: true
      t.datetime :expired_at

      t.timestamps
    end
  end
end
