# frozen_string_literal: true

class AddColumnIntervalToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :interval, :integer
    add_column :locations, :day_out, :integer
  end
end
