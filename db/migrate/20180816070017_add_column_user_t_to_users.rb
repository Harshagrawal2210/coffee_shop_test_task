# frozen_string_literal: true

class AddColumnUserTToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :u_type, :string, default: 'other'
  end
end
