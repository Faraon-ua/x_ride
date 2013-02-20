class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.string :available
      t.string :brand_name
      t.integer :part_type_id
      t.integer :user_id

      t.timestamps
    end
  end
end
