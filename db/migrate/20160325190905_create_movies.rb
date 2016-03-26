class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title, index: true
      t.string :genres

      t.timestamps null: false
    end
  end
end
