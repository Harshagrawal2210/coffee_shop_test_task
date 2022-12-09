# frozen_string_literal: true

class AddRowOrderToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :row_order, :integer
    add_index :products, :row_order
  end
end
