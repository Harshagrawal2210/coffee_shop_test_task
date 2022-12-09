# frozen_string_literal: true

class CreateOrderItemAttrs < ActiveRecord::Migration[5.2]
  def change
    create_table :order_item_attrs do |t|
      t.references :order_item, foreign_key: true
      t.references :order, foreign_key: true
      t.references :category, foreign_key: true
      t.string :category_name
      t.references :product, foreign_key: true
      t.string :product_name
      t.string :product_description

      t.timestamps
    end
  end
end
