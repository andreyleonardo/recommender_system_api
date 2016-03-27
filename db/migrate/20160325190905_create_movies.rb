class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title, index: true
      t.integer :movielens_id, index: true      

      t.timestamps null: false
    end
  end
end
