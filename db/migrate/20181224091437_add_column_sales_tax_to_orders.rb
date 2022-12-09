# frozen_string_literal: true

class AddColumnSalesTaxToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :sales_tax, :decimal, precision: 10, scale: 3
  end
end
