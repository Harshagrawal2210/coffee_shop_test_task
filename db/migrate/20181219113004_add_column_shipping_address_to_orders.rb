# frozen_string_literal: true

class AddColumnShippingAddressToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :shipping_address, :text
  end
end
