# frozen_string_literal: true

class AddRowOrderToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :row_order, :integer
    add_index :categories, :row_order
  end
end
