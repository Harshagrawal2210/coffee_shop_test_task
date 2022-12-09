# frozen_string_literal: true

class ProductToAttribute < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :product, optional: true
end
