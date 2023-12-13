class DropPostTags < ActiveRecord::Migration[6.1]
  def change
    drop_table :post_tags do |t|
      
      t.references :post, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
    end
  end
end
