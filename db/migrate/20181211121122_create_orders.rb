# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :order_no
      t.integer :user_id, default: 0
      t.string :name
      t.string :email
      t.string :phone
      t.decimal :gross_amout, precision: 10, scale: 2
      t.decimal :total_amout, precision: 10, scale: 2
      t.decimal :tax_amout, precision: 10, scale: 2
      t.decimal :amout_receive, precision: 10, scale: 2
      t.decimal :amout_pending, precision: 10, scale: 2
      t.string :uniq_token
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
