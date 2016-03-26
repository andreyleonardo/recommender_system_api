class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.integer :imdb_id
      t.integer :tmdb_id
      t.references :movie, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
