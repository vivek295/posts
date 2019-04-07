class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    unless table_exists? :posts
      create_table :posts do |t|
        t.string :caption
        t.datetime :deleted_at

        t.timestamps
      end
    end
  end
end
