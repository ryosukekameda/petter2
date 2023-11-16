class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|

      t.integer :reporter_id, null: false
      t.integer :repoted_id, null: false
      t.integer :content_id, null: false
      t.string :content_type, null: false
      t.integer :reason, null: false
      t.boolean :is_checked, null: false
      t.timestamps
    end
  end
end
