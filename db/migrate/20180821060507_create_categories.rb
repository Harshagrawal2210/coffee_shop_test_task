# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :title
      t.text :description
      t.integer :sub_category_id, default: 0
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
