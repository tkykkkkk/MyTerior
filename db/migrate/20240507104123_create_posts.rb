class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false 
      t.text :caption, null: false 
      t.string :room_layout_id

      t.timestamps
    end
  end
end
