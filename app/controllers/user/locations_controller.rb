# frozen_string_literal: true

module User
  class LocationsController < ApplicationController
    before_action :set_location, only: %i[show edit update destroy]

    include ApplicationHelper

    # GET /user/locations
    # GET /user/locations.json
    def index
      @locations = Location.paginate(page: params[:page], per_page: 25).order('row_order ASC')
    end

    # GET /user/locations/1
    # GET /user/locations/1.json
    def show; end

    # GET /user/locations/new
    def new
      @location = Location.new
      @location.build_asset
    end

    # GET /user/locations/1/edit
    def edit
      @location.build_asset if @location.asset.nil?
    end

    # POST /user/locations
    # POST /user/locations.json
    def create
      @location = Location.new(location_params)

      respond_to do |format|
        if @location.save
          format.html { redirect_to user_locations_path, notice: 'Location was successfully created.' }
          format.json { render :show, status: :created, location: @location }
        else
          @location.build_asset if @location.asset.nil?
          format.html { render :new }
          format.json { render json: @location.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /user/locations/1
    # PATCH/PUT /user/locations/1.json
    def update
      if location_params[:asset_attributes].nil?
        params[:location].delete :asset_attributes
      elsif location_params[:asset_attributes][:image].nil?
        params[:location].delete :asset_attributes
      end

      respond_to do |format|
        if @location.update(location_params)
          format.html { redirect_to user_locations_path, notice: 'Location was successfully updated.' }
          format.json { render :show, status: :ok, location: @location }
        else
          @location.build_asset if @location.asset.nil?
          format.html { render :edit }
          format.json { render json: @location.errors, status: :unprocessable_entity }
        end
      end
    end

    # update order of locations by sorting and ordering
    def update_order
      if !params[:order].nil? || params[:order].split(',').length.positive?
        params[:order].split(',').each_with_index do |o, index|
          location = Location.find_by(id: o.to_i)
          location&.update(row_order: index)
        end
      end
      render json: true
      nil
    end

    # DELETE /user/locations/1
    # DELETE /user/locations/1.json
    def destroy
      @location.destroy
      respond_to do |format|
        format.html { redirect_to user_locations_path, notice: 'Location was successfully deleted.' }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.

    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      p = params.require(:location).permit(:title, :address, :office_telephone, :longitude, :latitude, :start_time,
                                           :end_time, :location_open, :location_close, :interval, :day_out, :url_handle, aval_week: [], asset_attributes: [:image])
      unless params[:location][:start_time].to_s.empty?
        p[:start_time] =
          parse_row_date_time(params[:location][:start_time])
      end
      p[:end_time] = parse_row_date_time(params[:location][:end_time]) unless params[:location][:end_time].to_s.empty?
      unless params[:location][:location_open].to_s.empty?
        p[:location_open] =
          parse_row_date_time(params[:location][:location_open])
      end
      unless params[:location][:location_close].to_s.empty?
        p[:location_close] =
          parse_row_date_time(params[:location][:location_close])
      end
      p
    end
  end
end
