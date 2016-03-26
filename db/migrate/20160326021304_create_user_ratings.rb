class CreateUserRatings < ActiveRecord::Migration
  def change
    create_table :user_ratings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :rating, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
