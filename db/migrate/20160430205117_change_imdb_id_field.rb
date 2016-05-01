class ChangeImdbIdField < ActiveRecord::Migration
  def change
    change_column :links, :imdb_id, :string
  end
end
