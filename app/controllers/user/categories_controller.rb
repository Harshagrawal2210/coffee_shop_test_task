# frozen_string_literal: true

class User::CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]

  # GET /user/categories
  # GET /user/categories.json
  def index
    @categories = Category.where('sub_category_id != ?', 0)
    @category_title = params[:category_title].to_s.strip
    @category_id = params[:sub_category].to_i

    unless params[:category_title].nil?
      @categories = @categories.where('lower(title) LIKE ? OR lower(description) LIKE ?',
                                      "%#{@category_title.downcase}%", "%#{@category_title.downcase}%")
    end
    unless params[:sub_category].nil? || params[:sub_category].empty?
      @categories = @categories.where(sub_category_id: @category_id)
    end
    @categories = @categories.order('row_order ASC')

    response_status = { response_code: 200, response_type: 'success' }
    result = { response_status: response_status, response_data: @categories }
    render json: result, status: result[:response_status][:response_code]
    nil
  end

  # GET /user/categories/1
  # GET /user/categories/1.json
  def show; end

  # GET /user/categories/new
  def new
    @category = Category.new
  end

  # GET /user/categories/1/edit
  def edit; end

  # POST /user/categories
  # POST /user/categories.json
  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to user_categories_path, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user/categories/1
  # PATCH/PUT /user/categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to user_categories_path, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user/categories/1
  # DELETE /user/categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to user_categories_path, notice: 'Category was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  # update order of locations by sorting and ordering
  def update_order
    if !params[:order].nil? || params[:order].split(',').length.positive?
      params[:order].split(',').each_with_index do |o, index|
        category = Category.find_by(id: o.to_i)
        category&.update(row_order: index)
      end
    end
    render json: true
    nil
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.

  def category_params
    params.require(:category).permit(:title, :description, :sub_category_id, :status)
  end
end
