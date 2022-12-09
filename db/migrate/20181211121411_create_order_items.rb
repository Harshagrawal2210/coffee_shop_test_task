# frozen_string_literal: true

class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true
      t.references :product, foreign_key: true
      t.string :product_name
      t.text :product_description
      t.integer :product_qty
      t.string :product_qty_type
      t.boolean :is_attribute, default: false

      t.timestamps
    end
  end
end
