class CreateGenres < ActiveRecord::Migration
  def change
    create_table :genres do |t|
      t.name :string

      t.timestamps null: false
    end
  end
end
