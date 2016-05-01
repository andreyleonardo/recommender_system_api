class CreateMovieDescribers < ActiveRecord::Migration
  def change
    create_table :movie_describers do |t|
      t.references :movie, index: true, foreign_key: true
      t.references :describer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
