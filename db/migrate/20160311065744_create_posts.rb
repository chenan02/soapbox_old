class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content
      t.integer :stream_id

      t.timestamps null: false
    end
  end
end
