# frozen_string_literal: true

class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :title
      t.text :address
      t.string :fax
      t.string :office_telephone
      t.string :longitude
      t.string :latitude
      t.string :licence_no
      t.integer :row_order
      t.string :url_handle
      t.string :placeid

      t.timestamps
    end
  end
end
