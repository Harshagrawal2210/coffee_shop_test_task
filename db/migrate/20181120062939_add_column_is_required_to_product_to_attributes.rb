# frozen_string_literal: true

class AddColumnIsRequiredToProductToAttributes < ActiveRecord::Migration[5.2]
  def change
    add_column :product_to_attributes, :is_required, :boolean, default: true
  end
end
