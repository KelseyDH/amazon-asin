class CreateProductScrapes < ActiveRecord::Migration[5.2]
  def change
    create_table :product_scrapes do |t|
      t.jsonb :data
      t.integer :rank
      t.string :category, null: false
      t.string :product_dimensions
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
