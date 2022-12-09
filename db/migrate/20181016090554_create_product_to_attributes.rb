# frozen_string_literal: true

class CreateProductToAttributes < ActiveRecord::Migration[5.2]
  def change
    create_table :product_to_attributes do |t|
      t.string :title
      t.string :description
      t.references :category, foreign_key: true
      t.references :product, foreign_key: true
      t.string :qty_type
      t.integer :qty

      t.timestamps
    end
  end
end
