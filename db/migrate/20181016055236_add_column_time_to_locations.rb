# frozen_string_literal: true

class AddColumnTimeToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :start_time, :datetime
    add_column :locations, :end_time, :datetime
    add_column :locations, :aval_week, :string, array: true, default: [0, 1, 2, 3, 4, 5, 6]
  end
end
