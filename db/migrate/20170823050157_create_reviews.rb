class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :quality
      t.integer :value
      t.integer :style
      t.integer :utility
      t.integer :enjoyment
      t.boolean :recommend

      t.timestamps

    end
  end
end
