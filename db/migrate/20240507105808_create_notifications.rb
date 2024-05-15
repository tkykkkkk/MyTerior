class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id
      t.integer :visited_id
      t.references :post, foreign_key: true
      t.references :postcomment, foreign_key: true
      t.string :action
      t.boolean :checked, default: false 
      
      t.timestamps
    end 
  end 
end
