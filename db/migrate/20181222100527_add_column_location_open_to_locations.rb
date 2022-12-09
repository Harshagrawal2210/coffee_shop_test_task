# frozen_string_literal: true

class AddColumnLocationOpenToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :location_open, :datetime
    add_column :locations, :location_close, :datetime
  end
end
