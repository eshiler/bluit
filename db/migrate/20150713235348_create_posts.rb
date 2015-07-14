class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, limit: 160
      t.string :link, limit: 2000
      t.text :body
      t.timestamps
    end
  end
end
