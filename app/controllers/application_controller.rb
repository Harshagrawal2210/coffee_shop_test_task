# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # add_flash_types :error, :notice, :alert, :success, :warning
  protect_from_forgery with: :null_session

  def set_session!
    #  pre_order session
    session['cart'] ||= {}
    session['cart']['location'] ||= {}
    session['cart']['location']['product'] ||= []
    session['cart']['location']['location_id'] ||= {}
    session['cart']['location']['date'] ||= {}
    session['cart']['location']['time'] ||= {}
    session['cart']['location']['created_at'] ||= {}

    #  online shopping session
    session['cart']['online_store'] ||= {}
    session['cart']['online_store']['product'] ||= []
    session['cart']['online_store']['created_at'] ||= {}
  rescue Exception => e
    puts "ApplicationController session error occur #{e}"
  end

  # This function will be redirect to 404 page
  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end
end
