class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true, null: false 
      t.references :genre, foreign_key: true
      t.string :caption 

      t.timestamps
    end
  end
end
