class CreateComments < ActiveRecord::Migration[5.2]
  def change
    unless table_exists? :comments
      create_table :comments do |t|
        t.string :text
        t.datetime :deleted_at
        t.references :post, index: true, foreign_key: true
      end
    end
  end
end
