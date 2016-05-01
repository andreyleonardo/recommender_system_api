class CreateDescribers < ActiveRecord::Migration
  def change
    create_table :describers do |t|
      t.string :name, index: {unique: :true}

      t.timestamps null: false
    end
  end
end
