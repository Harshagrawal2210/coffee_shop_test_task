# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  has_many :order_item_attrs, dependent: :destroy

  def total_price
    (price * product_qty)
  end

  def order_item_attributes
    order_item_attrs.group_by(&:category_name)
  end
end
