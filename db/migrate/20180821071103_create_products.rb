# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.references :category, foreign_key: true
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
