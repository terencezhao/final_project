class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.integer :category_id
      t.integer :brand_id
      t.float :price
      t.string :image_url
      t.string :details
      t.string :name

      t.timestamps

    end
  end
end
