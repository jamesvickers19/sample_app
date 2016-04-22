class CreatePostEncouragements < ActiveRecord::Migration
  def change
    create_table :post_encouragements do |t|
      t.integer :encouraged_id
      t.integer :encourager_id

      t.timestamps null: false
    end
    add_index :post_encouragements, :encouraged_id
    add_index :post_encouragements, :encourager_id
    add_index :post_encouragements, [:encourager_id, :encouraged_id], unique: true
  end
end
