class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.integer :parent_id

      t.timestamps
    end

    add_index :categories, :name, :unique => true
    add_index :categories, :parent_id
  end
end
