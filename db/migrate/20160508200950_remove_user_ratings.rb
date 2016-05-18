class RemoveUserRatings < ActiveRecord::Migration
  def change
    drop_table :user_ratings
  end
end
