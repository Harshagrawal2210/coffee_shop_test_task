# frozen_string_literal: true

class AddColumnSpecRequestToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :spec_request, :text
  end
end
