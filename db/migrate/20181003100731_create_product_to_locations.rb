# frozen_string_literal: true

class CreateProductToLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :product_to_locations do |t|
      t.references :product, foreign_key: true
      t.references :location, foreign_key: true

      t.timestamps
    end
  end
end
