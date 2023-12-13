class DropPostTags < ActiveRecord::Migration[6.1]
  def change
    drop_table :post_tags do |t|
      
      t.bigint :post_id
      t.bigint :tag_id
      t.timestamps
    end
  end
end
