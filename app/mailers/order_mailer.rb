# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  helper ApplicationHelper

  def order_confirm(order)
    @order = order
    email = @order.email
    mail(to: email.to_s, subject: "Pre-Order Confirmation: ##{@order.order_no}")
  end

  def online_order_confirm(order)
    @order = order
    email = @order.email
    mail(to: email.to_s, subject: "Online Order Confirmation: ##{@order.order_no}")
  end

  def order_reminder(order)
    @order = order
    email = @order.email
    mail(to: email.to_s, subject: "Order Reminder: ##{@order.order_no}")
  end
end
