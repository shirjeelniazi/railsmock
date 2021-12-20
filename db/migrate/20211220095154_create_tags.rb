class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.integer :book_id
      t.boolean :tag1
      t.boolean :tag2
      t.boolean :tag3

      t.timestamps
    end
  end
end
