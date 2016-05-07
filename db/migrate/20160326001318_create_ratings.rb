class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.float :score
      t.references :movie, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
