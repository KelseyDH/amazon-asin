class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :asin, null: false

      t.timestamps
    end
    add_index :products, :asin, unique: true
  end
end
