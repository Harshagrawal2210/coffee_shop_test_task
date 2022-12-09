# frozen_string_literal: true

class AddColumnToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :aval_week, :string, array: true, default: [0, 1, 2, 3, 4, 5, 6]
  end
end
