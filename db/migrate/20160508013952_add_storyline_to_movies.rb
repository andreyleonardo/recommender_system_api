class AddStorylineToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :storyline, :string
  end
end
