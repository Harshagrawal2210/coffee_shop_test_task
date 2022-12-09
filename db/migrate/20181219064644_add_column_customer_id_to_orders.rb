# frozen_string_literal: true

class AddColumnCustomerIdToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :customer_id, :string
  end
end
