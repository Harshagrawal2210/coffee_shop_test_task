# frozen_string_literal: true

class OrderItemAttr < ApplicationRecord
  belongs_to :order_item
  belongs_to :order
  belongs_to :category
  belongs_to :product
end
