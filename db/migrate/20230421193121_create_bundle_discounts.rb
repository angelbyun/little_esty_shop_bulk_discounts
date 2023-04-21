class CreateBundleDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bundle_discounts do |t|
      t.integer :item_quantity
      t.integer :discount
      t.references :merchant, foreign_key: true

      t.timestamps
    end
  end
end
