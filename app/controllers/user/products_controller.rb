# frozen_string_literal: true

  class User::ProductsController < ApplicationController
    include ApplicationHelper
    before_action :set_product, only: %i[show edit update destroy product_details status]
    before_action :set_category, only: %i[product_list product_details]

    # GET /user/products
    # GET /user/products.json

    def index
      @products = Product.includes(:category).all
      @product_title = params[:product_title].to_s.strip
      @category = params[:category].to_i

      unless params[:product_title].nil?
        @products = @products.where('lower(title) LIKE ? OR lower(description) LIKE ?', "%#{@product_title.downcase}%",
                                    "%#{@product_title.downcase}%")
      end
      @products = @products.where(category_id: @category) unless params[:category].nil? || params[:category].empty?
      @products = @products.order('row_order ASC')

      @all_products = []

      @products.each do |product|
        @all_products << { product: product, product_item: product.product_to_qties }
      end

      response_status = { response_code: 200, response_type: 'success' }
      result = { response_status: response_status, response_data: @all_products }
      render json: result, status: result[:response_status][:response_code]
      nil
    end

    # GET /user/products/1
    # GET /user/products/1.json
    def show
      respond_to do |format|
        format.js
      end
    end

    def online_product
      unless params[:sub_category_id].nil?
        case params[:sub_category_id].to_i
        when 1
          unless params[:category_id].nil? && params[:location_id].nil?
            @category = Category.category_location(params[:location_id], params[:category_id]).first
          end
        when 2
          @category = Category.includes(products: %i[product_to_qties asset]).find_by_id(params[:category_id])
        end
      end
      render layout: false
    end

    def cart_date_time
      result = {}
      session['cart'] ||= {}
      session['cart']['location'] ||= {}
      session['cart']['location']['date'] ||= {}
      session['cart']['location']['time'] ||= {}
      session['cart']['location']['created_at'] ||= {}

      unless params[:location_id].nil? && params[:date].nil? && params[:time].nil?
        session['cart']['location']['location_id'] = params[:location_id]
        session['cart']['location']['date'] = params[:date]
        session['cart']['location']['time'] = params[:time]
        session['cart']['location']['created_at'] = Time.now
      end
      @all_product_list = render_to_string partial: 'all_product_list',
                                           locals: {
                                             categories: Category.location(session['cart']['location']['location_id']), carts: session[:cart]
                                           }

      result = { type: 'success', location_id: session['cart']['location']['location_id'],
                 date: session['cart']['location']['date'], time: session['cart']['location']['time'], data: @all_product_list }
      render json: result
      nil
    end

    def cart_cancel
      session['cart'] = {}
      session['cart']['location'] = {}
      session['cart']['location']['product'] = []
      session['cart']['location']['location_id'] = {}
      session['cart']['location']['date'] = {}
      session['cart']['location']['created_at'] = {}
      session['cart']['location']['time'] = {}

      result = { type: 'success', message: 'Your cart is empty!', count: product_count, grand_total: grand_total.to_f,
                 grand_total_tax: grand_total_tax, grand_total_wtax: grand_total_with_tax }
      render json: result
      nil
    end

    def add_cart
      result = {}
      session['cart'] ||= {}

      # for pre_order
      session['cart']['location'] ||= {}
      session['cart']['location']['product'] ||= []
      #  online shopping session
      session['cart']['online_store'] ||= {}
      session['cart']['online_store']['product'] ||= []
      session['cart']['online_store']['created_at'] ||= {}

      @product = Product.find_by(id: params[:products][:id])
      @product_item = ProductToQty.find_by(id: params[:products][:product_item_id], product_id: params[:products][:id])

      unless params[:products].nil?
        case params[:products][:sub_category_id].to_i
        when 1
          product = session['cart']['location']['product'].find do |a|
            a['id'].to_i == params[:products][:id].to_i && a['qty_type'].to_s == @product_item.qty_type.to_s
          end
          if product.present?
            product['quantity'] = (product['quantity'].to_i + params['products']['quantity'].to_i)
            product['total'] = (product['quantity'].to_i * @product_item.price.to_f)
            result = { data: product, count: product_count, grand_total: grand_total.to_f,
                       grand_total_tax: grand_total_tax, grand_total_wtax: grand_total_with_tax, update: true }
          else
            session['cart']['location']['product'] << params[:products].merge!(session_id: rand(36**8).to_s(36),
                                                                               total: (params[:products][:quantity].to_i * @product_item.price.to_f))
            result = { data: session['cart']['location']['product'].last, count: product_count,
                       grand_total: grand_total.to_f, grand_total_tax: grand_total_tax, grand_total_wtax: grand_total_with_tax, update: true }
          end

        when 2
          product = session['cart']['online_store']['product'].find do |a|
            a['id'].to_i == params[:products][:id].to_i && a['qty_type'].to_s == @product_item.qty_type.to_s
          end
          if product.present?
            product['quantity'] = (product['quantity'].to_i + params['products']['quantity'].to_i)
            product['total'] = (product['quantity'].to_i * @product_item.price.to_f)
            result = { data: product, count: online_product_count, grand_total: online_grand_total.to_f,
                       grand_total_tax: online_grand_total_tax, grand_total_wtax: online_grand_total_with_tax, update: true }
          else
            session['cart']['online_store']['product'] << params[:products].merge!(session_id: rand(36**8).to_s(36),
                                                                                   total: (params[:products][:quantity].to_i * @product_item.price.to_f))
            result = { data: session['cart']['online_store']['product'].last, count: online_product_count,
                       grand_total: online_grand_total.to_f, grand_total_tax: online_grand_total_tax, grand_total_wtax: online_grand_total_with_tax, update: true }
          end
        end
      end
      response_status = { response_code: 200, response_type: 'success',
                          message: 'Item has been successfully added to your cart' }
      result = { response_status: response_status, response_data: result }
      render json: result, status: result[:response_status][:response_code]
      nil
    end

    def product_count
      session['cart']['location']['product'].size
    end

    def product_details; end

    def category_price
      @product = Product.find_by_id(params[:id]) unless params[:id].nil?

      unless params[:sub_category_id].nil?
        case params[:sub_category_id].to_i
        when 1
          @prod_qty = Product.qty_type
        when 2
          @prod_qty = Product.online_qty_type
        end
      end
      render layout: false
    end

    def product_attributes
      render layout: false
    end

    def status
      respond_to do |_format|
        if @product.update(status: params[:status])
          render json: @product
          return
        end
      end
    end

    # GET /user/products/new
    def new
      @product = Product.new
      @product.build_asset
      @product.product_to_qties.build
      @product.product_to_attributes.build
      @title = Category.show_category
      @location_title = Location.show_location
      @onlineprod_qty = Product.online_qty_type
      @prod_qty = Product.qty_type
    end

    # GET /user/products/1/edit
    def edit
      @product.build_asset if @product.asset.nil?

      @product.product_to_qties.build if @product.product_to_qties.nil?

      @product.product_to_attributes.build if @product.product_to_attributes.nil?

      @title = Category.show_category
      @location_title = Location.show_location
      @prod_qty = Product.qty_type
      @onlineprod_qty = Product.online_qty_type
    end

    # POST /user/products
    # POST /user/products.json
    def create
      @product = Product.new(product_params)

      # validate price
      @product.price = (@product.product_to_qties.first.price if @product.product_to_qties.present?)
      # validate category
      @product.sub_category_id = (@product.category.sub_category_id unless @product.category.nil?)

      #  validate location
      @product.location_id = (location_params.first[:location_id] unless location_params.first.nil?)

      respond_to do |format|
        if @product.save
          ProductToLocation.save_ptl_association(@product, location_params)
          format.html { redirect_to user_products_path, notice: 'Product was successfully created.' }
          format.json { render :show, status: :created, location: @product }
        else

          @product.build_asset if @product.asset.nil?

          @product.product_to_qties.build(product_to_qty_params) if @product.product_to_qties.nil?

          @product.product_to_attributes.build(product_to_attr_params) if @product.product_to_attributes.nil?
          # @product.product_to_qties.build(product_to_qty_params)
          @product.product_to_locations.build(location_params)
          # @product.product_to_attributes.build(product_to_attr_params)
          @prod_qty = Product.qty_type
          @onlineprod_qty = Product.online_qty_type
          @title = Category.show_category
          @location_title = Location.show_location
          format.html { render :new }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /user/products/1
    # PATCH/PUT /user/products/1.json
    def update
      if product_params[:asset_attributes].nil?
        params[:product].delete :asset_attributes
      elsif product_params[:asset_attributes][:image].nil?
        params[:product].delete :asset_attributes
      end

      # render json: product_params
      # return

      respond_to do |format|
        @product.product_to_qties.destroy_all
        @product.product_to_attributes.destroy_all

        # validate price
        @product.price = if product_params[:product_to_qties_attributes]['0'][:price].present?
                           product_params[:product_to_qties_attributes]['0'][:price]
                         end
        # validate category
        @product.sub_category_id = (@product.category.sub_category_id unless @product.category.nil?)

        #  validate location
        @product.location_id = (location_params.first[:location_id] unless location_params.first.nil?)

        if @product.update(product_params)
          ProductToLocation.save_ptl_association(@product, location_params)
          format.html { redirect_to user_products_path, notice: 'Product was successfully updated.' }
          format.json { render :show, status: :ok, location: @product }
        else
          @product.build_asset if @product.asset.nil?
          @product.product_to_qties.build(product_to_qty_params) if @product.product_to_qties.nil?

          @product.product_to_attributes.build(product_to_attr_params) if @product.product_to_attributes.nil?
          # @product.product_to_qties.build(product_to_qty_params)
          # @product.product_to_attributes.build(product_to_attr_params)
          @product.product_to_locations.build(location_params)
          @onlineprod_qty = Product.online_qty_type
          @prod_qty = Product.qty_type
          @title = Category.show_category
          @location_title = Location.show_location
          format.html { render :edit }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /user/products/1
    # DELETE /user/products/1.json
    def destroy
      @product.destroy
      respond_to do |format|
        format.html { redirect_to user_products_path, notice: 'Product was successfully deleted.' }
        format.json { head :no_content }
      end
    end

    # update order of locations by sorting and ordering
    def update_order
      if !params[:order].nil? || params[:order].split(',').length.positive?
        params[:order].split(',').each_with_index do |o, index|
          product = Product.find_by(id: o.to_i)
          product&.update(row_order: index)
        end
      end
      render json: true
      nil
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      if params[:id].nil?
        @product = Product.where("REGEXP_REPLACE(lower(title),'[^a-z0-9\\-_]','_','g') = ?",
                                 params[:product_title]).first
        not_found if @product.nil?
      else
        @product = Product.find(params[:id]) || not_found
      end
    end

    def set_category
      if params[:category_id].nil?
        @category = Category.where("REGEXP_REPLACE(lower(title),'[^a-z0-9\\-_]','_','g') = ?",
                                   params[:category_title]).first
        not_found if @category.nil?
      else
        @category = Category.find(params[:category_id]) || not_found
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :category_id, aval_week: [], asset_attributes: [:image],
                                                                          product_to_qties_attributes: %i[price qty_type], product_to_attributes_attributes: %i[title description category_id is_required qty])
    end

    def product_to_qty_params
      params.require(:product).permit(product_to_qties_attributes: %i[price qty_type])
    end

    def product_to_attr_params
      params.require(:product).permit(product_to_attributes_attributes: %i[title description category_id
                                                                           is_required qty])
    end

    # use param to save another model
    def location_params
      p = params.require(:product).require(:location).permit([{ location_id: [] }])
      p[:location_id] = [] if p[:location_id].nil?
      result = []
      p[:location_id].each do |v|
        result.push({ location_id: v.to_i }) if v.to_i.positive?
      end
      result
    end
  end
