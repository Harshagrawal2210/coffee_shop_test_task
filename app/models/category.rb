# frozen_string_literal: true

class Category < ApplicationRecord
  validates :title, presence: true
  validates :sub_category_id, presence: true
  validates :title, uniqueness: true

  has_many :products, dependent: :nullify

  before_create :save_row_order

  belongs_to :sub_category, class_name: 'Category', foreign_key: 'sub_category_id', optional: true

  scope :location, lambda { |id|
                     includes(:products).joins(:products).merge(Product.includes(:product_to_qties, :asset).location_data(id))
                   }

  scope :category_location, lambda { |id, category_id|
                              includes(:products).where('categories.id = ?', category_id).joins(:products).merge(Product.includes(:product_to_qties, :asset).location_data(id))
                            }

  def self.show_category
    Category.where('sub_category_id != ?', 0).includes(:sub_category).all.map do |e|
      [e.title, e.id, { 'data-sub_category_id' => e.sub_category.id }]
    end
  end

  def self.show_category_html
    Category.where('sub_category_id != ?', 0).includes(:sub_category).all.map do |e|
      [e.title, e.id, e.sub_category.id]
    end
  end

  def url_name
    title.downcase.to_s.gsub(/[^a-z0-9\-_]+/, '_')
  end

  def self.show_title(id)
    Category.find_by_id(id).title
  end

  def parent_menu
    return 'Menu' if sub_category_id == 1

    'Online Store'
  end

  def save_row_order
    # maxOrder = Product.maximum("row_order")
    # self.row_order = maxOrder + 1
  end

  def self.online_category
    @category = Category.where('sub_category_id != ?', 0).where(sub_category_id: 2)
  end
end
