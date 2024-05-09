class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true, null: false 
      t.references :room_layout, foreign_key: true, null: false
      t.text :caption, null: false 

      t.timestamps
    end
  end
end
