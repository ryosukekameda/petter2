class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|

      t.integer :visiter_id, null: false
      t.integer :visited_id, null: false
      t.integer :post_id
      t.integer :comment_id
      t.integer :favorite_id
      t.integer :relationship_id
      t.string :action, null: false
      t.boolean :is_checked, null: false
      t.timestamps
    end
  end
end
