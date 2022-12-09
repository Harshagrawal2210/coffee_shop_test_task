# frozen_string_literal: true

class CreateProductToQties < ActiveRecord::Migration[5.2]
  def change
    create_table :product_to_qties do |t|
      t.references :product, foreign_key: true
      t.float :price
      t.string :qty_type

      t.timestamps
    end
  end
end
