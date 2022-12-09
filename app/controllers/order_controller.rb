# frozen_string_literal: true

class OrderController < ApplicationController
  include ApplicationHelper

  before_action :set_order,
                only: %i[confirmation charge online_confirmation show invoice_meat pre_order_status charge_status]

  def place_order
    # @order = Order.new(order_params)
    # unless @order.valid?
    #   result = { type: 'error', message: @order.errors.full_messages }
    #   render json: result
    #   return
    # end

    # begin
    #   @order = Order.new(user_id: (user_signed_in? ? current_user.id : 0).to_s, name: order_params[:name],
    #                      email: order_params[:email], phone: order_params[:phone], gross_amout: grand_total, total_amout: grand_total_with_tax, tax_amout: grand_total_tax, amout_receive: grand_total_with_tax, amout_pending: 0, sales_tax: pre_sales_tax, uniq_token: random_code, order_date: order_date, order_time: order_time, location_id: order_location, spec_request: order_params[:spec_request], customer_id: customer.id, order_type: 'pre')

    #   if @order.save
    #     session['cart']['location']['product'].each do |product|
    #       @order_item = @order.order_items.new(product_id: product['id'], product_name: product['name'],
    #                                            product_description: product['description'], product_qty: product['quantity'], product_qty_type: product['qty_type'], is_attribute: product['product_to_attributes'].present?, price: product['price'].to_i)
    #       @order_item.save
    #       if @order_item.is_attribute == true
    #         product['product_to_attributes'].each do |prod_cate, prod_ids|
    #           category_id = prod_cate[0].split('_').first
    #           @catgory = Category.find_by(id: category_id)
    #           next unless @catgory.present?

    #           prod_ids.each do |pid|
    #             @product = Product.find_by(id: pid)
    #             next unless @product.present?

    #             @order_item_attr = @order_item.order_item_attrs.new(order_id: @order.id, category_id: @catgory.id,
    #                                                                 category_name: @catgory.title, product_id: @product.id, product_name: @product.title, product_description: @product.description)
    #             @order_item_attr.save
    #           end
    #         end
    #       end
    #       session['cart'] = {}
    #       session['cart']['location'] = {}
    #       session['cart']['location']['product'] = []
    #       session['cart']['location']['location_id'] = {}
    #       session['cart']['location']['date'] = {}
    #       session['cart']['location']['created_at'] = {}
    #       session['cart']['location']['time'] = {}
    #     end
    #     flash[:notice] = 'Thank you! Your payment has been received successfully.'
    #     result = { type: 'success', data: @order }
    #   end
    # rescue Exception => e
    #   puts e.to_s
    #   render json: result = { type: 'error', message: [e.message] }
    #   return
    # end
    # render json: result
    # nil
  end

  private

  def set_order
    @order = Order.find_by_uniq_token(params[:order_token])
  end

  def order_params
    params.require(:order).permit(:order_no, :user_id, :name, :email, :phone, :gross_amout, :total_amout, :tax_amout,
                                  :amout_receive, :amout_pending, :uniq_token, :status, :order_date, :order_time, :sales_tax, :location_id, :spec_request, :order_type, :customer_id, shipping_address: {})
  end
end
# t.boolean "is_attribute", default: false
