# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  validates :name, :phone, presence: true
  validates :email, presence: true, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/
  belongs_to :location, optional: true
  belongs_to :user, class_name: 'User', foreign_key: 'user_id', optional: true

  serialize :shipping_address

  after_save :order_no_generate

  def order_no_generate
    update(order_no: Time.now.to_i) if order_no.nil?
  end

  def self.all_order_status
    [
      ['Pending', 0],
      ['Paid & Picked Up', 1],
      ['Cancelled', 2]
    ]
  end

  def self.reminder_send
    Order.where(status: 0).each do |order|
      puts order.to_s
      OrderMailer.order_reminder(order).deliver_now
    end
  end

  def sales_tax_percent
    "#{sales_tax * 100}%"
  end

  def order_status
    case status
    when 0
      '<span class="label label-primary">Pending</span>'.html_safe
    when 1
      '<span class="label label-success">Paid & Picked Up</span>'.html_safe
    when 2
      '<span class="label label-danger">Cancelled</span>'.html_safe
    end
  end
end
