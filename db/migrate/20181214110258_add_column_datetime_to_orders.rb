# frozen_string_literal: true

class AddColumnDatetimeToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :order_date, :datetime
    add_column :orders, :order_time, :datetime
    add_column :orders, :stripe_data, :text
    add_column :orders, :stripe_trans_id, :string
    add_reference :orders, :location, foreign_key: true
  end
end
