class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :link
      t.string :title
      t.datetime :date
      t.string :author
      t.text :small_description
      t.string :image
      t.boolean :source
      t.timestamps
    end
  end
end
