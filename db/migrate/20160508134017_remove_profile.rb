class RemoveProfile < ActiveRecord::Migration
  def change
    remove_column :users, :profile_id
    drop_table :profiles
  end
end
