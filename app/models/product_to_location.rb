# frozen_string_literal: true

class ProductToLocation < ApplicationRecord
  belongs_to :product, optional: true
  belongs_to :location, optional: true

  def self.save_ptl_association(prObj, location_param)
    location_param = location_param.to_a
    prObj.product_to_locations.destroy_all
    prObj.product_to_locations.build(location_param)
    prObj.save
  end
end
