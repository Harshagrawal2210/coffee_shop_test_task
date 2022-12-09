# frozen_string_literal: true

class AddColumnImageProcToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image_processing, :boolean
  end
end
