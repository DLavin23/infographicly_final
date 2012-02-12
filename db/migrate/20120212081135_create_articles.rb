class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :item_num
      t.string :url
      t.string :title
      t.integer :state
      t.string :shortlink
      t.integer :time_added
      t.integer :time_updated
      t.integer :source_id
      t.integer :user_id

      t.timestamps
    end
  end
end
