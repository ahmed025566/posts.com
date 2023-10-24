class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :Title
      t.string :Text
      t.integer :CommentsCounter, default: 0
      t.integer :LikesCounter, default: 0
      t.references :author, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end