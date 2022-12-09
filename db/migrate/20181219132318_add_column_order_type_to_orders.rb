# frozen_string_literal: true

class AddColumnOrderTypeToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :order_type, :string
  end
end
