# frozen_string_literal: true

class AddColumnLocationToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :all_location, :text, default: [], array: true
    add_column :users, :permission, :text, default: [], array: true
  end
end
