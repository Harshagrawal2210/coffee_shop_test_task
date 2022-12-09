# frozen_string_literal: true

class ProductToQty < ApplicationRecord
  belongs_to :product, optional: true

  def self.save_ptq_association(prObj, price_params)
    prObj.product_to_qties.destroy_all
    prObj.product_to_qties.build(price_params)
    prObj.save
  end
end
