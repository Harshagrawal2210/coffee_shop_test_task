# frozen_string_literal: true

class Product < ApplicationRecord
  attr_accessor :location, :quantity, :product_items, :location_id, :sub_category_id, :price

  include ApplicationHelper

  belongs_to :category, optional: true

  scope :active_product, -> { where(status: 1) }

  has_many :product_to_locations, dependent: :destroy
  scope :location_data, lambda { |id|
                          active_product.order('products.row_order ASC').joins(:product_to_locations).where('location_id=?', id)
                        }

  has_many :product_to_qties, dependent: :destroy
  accepts_nested_attributes_for :product_to_qties, reject_if: proc { |att| att['price'].blank? }

  has_many :product_to_attributes, dependent: :destroy
  accepts_nested_attributes_for :product_to_attributes, reject_if: proc { |att| att['title'].blank? }

  validates :title, presence: true
  # validates :title, uniqueness: true
  validates :category_id, presence: true
  before_create :save_row_order

  validate :location_id_valid!

  def self.show_title(id)
    Product.find_by_id(id).title
  end

  def url_name
    title.downcase.to_s.gsub(/[^a-z0-9\-_]+/, '_')
  end

  def show_price
    product_to_qties.map do |e|
      [show_qty_type(e.qty_type), e.price.to_f, { 'data-qty_type' => show_qty_type(e.qty_type) }]
    end
  end

  def show_menu_price
    product_to_qties.pluck(:qty_type, :price)
  end

  def product_to_att
    product_to_attributes.group_by { |g| [g.category_id, g.qty] }
  end

  def self.qty_type
    [
      %w[LBS lbs],
      %w[LB lb],
      %w[Link link],
      %w[Links links],
      %w[Item item],
      %w[Single single],
      %w[Pint pint],
      %w[Quart quart],
      ['Half Pan', 'half_pan']

    ]
  end

  def self.online_qty_type
    [
      %w[Small small],
      %w[Medium medium],
      %w[Large large],
      %w[XLarge xlarge],
      %w[XXLarge xxlarge]
    ]
  end

  def save_row_order
    maxOrder = Product.maximum('row_order')
    self.row_order = maxOrder.to_i + 1
  end

  private

  def location_id_valid!
    errors.add(:location_id, "can't be blank?") if !sub_category_id.nil? && (sub_category_id == 1 && location_id.nil?)
  end

  # def price_validate!
  #   if price.nil?
  #     errors.add(:price,"can't be blank?")
  #   end
  # end
end
