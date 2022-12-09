# frozen_string_literal: true

class AddColumnPriceToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :price, :decimal, precision: 10, scale: 2
  end
end
