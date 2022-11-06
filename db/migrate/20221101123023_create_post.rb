class CreatePost < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :text
      t.integer :commentsCounter, default: 0
      t.integer :likesCounter, default: 0

      t.timestamps
    end
  end
end
