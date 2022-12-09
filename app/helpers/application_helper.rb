# frozen_string_literal: true

module ApplicationHelper
  def order_date
    parse_Datetime_combine(session['cart']['location']['date'], session['cart']['location']['time'])
  end

  def order_time
    parse_Datetime_combine(session['cart']['location']['date'], session['cart']['location']['time'])
  end

  def order_location
    session['cart']['location']['location_id']
  end

  def grand_total
    session['cart']['location']['product'].map { |e| e['total'].to_f }.sum
  end

  def grand_total_tax
    grand_total * pre_sales_tax
  end

  #  pre-order sales tax
  def pre_sales_tax
    (14.to_f / 100)
  end

  #  online sales tax
  def online_sales_tax
    if @web_setting[:online_sales_tax].nil?
      0
    else
      (@web_setting[:online_sales_tax].to_f / 100)
    end
  end

  def grand_total_with_tax
    grand_total + grand_total_tax
  end

  #  online order function

  def online_grand_total
    session['cart']['online_store']['product'].map { |e| e['total'].to_f }.sum
  end

  def online_grand_total_tax
    online_grand_total * online_sales_tax
  end

  def online_grand_total_with_tax
    online_grand_total + online_grand_total_tax
  end
  #  end

  def random_code(length = 64)
    rand(32**length).to_s(32).upcase
  end

  def show_qty_type(q_type)
    case q_type
    when 'lb'
      'LB'
    when 'lbs'
      'LBS'
    when 'link'
      'Link'
    when 'links'
      'Links'
    when 'item'
      'Item'
    when 'single'
      'Single'
    when 'pint'
      'Pint'
    when 'quart'
      'Quart'
    when 'half_pan'
      'Half Pan'
    when 'small'
      'Small'
    when 'medium'
      'Medium'
    when 'large'
      'Large'
    when 'xlarge'
      'XLarge'
    when 'xxlarge'
      'XXLarge'
    end
  end

  def set_week(day)
    case day
    when '0'
      'S'
    when '1'
      'M'
    when '2'
      'T'
    when '3'
      'W'
    when '4'
      'T'
    when '5'
      'F'
    when '6'
      'S'
    end
  end

  def priceToDoller(price)
    number_to_currency(price)
  end

  def PriceToDoller(price)
    number_to_currency(price)
  end

  def timezone
    'America/Phoenix'
  end

  def set_Formatted_Time(dt)
    dt.in_time_zone(timezone).strftime('%I:%M %p')
  end

  def set_Date_string(dt)
    dt.in_time_zone(timezone).strftime('%B %d, %Y')
  end

  def set_Date_With_Time(dt)
    dt.in_time_zone(timezone).strftime('%B %d, %Y %I:%M %p')
  end

  def set_Date(dt)
    dt.in_time_zone(timezone).strftime('%m/%d/%Y')
  end

  def parse_row_date_time(dt)
    return DateTime.parse(dt).strftime('%B %d, %Y %I:%M %p').in_time_zone(timezone).utc unless dt.to_s.empty?

    dt
  end

  def set_location_time(dt)
    dt.in_time_zone(timezone).strftime('%a, %d %b %Y %H:%M:%S')
  end

  def parse_Datetime_combine(dt, time)
    unless dt.to_s.empty?

      return DateTime.parse([dt, time].join(' ')).strftime('%B %d, %Y %I:%M %p').in_time_zone(timezone).utc
    end

    dt
  end

  def set_status
    [
      ['Active', 1],
      ['Disable', 0]
    ]
  end

  def set_sub_category
    [
      ['Menu', 1],
      ['Online Store', 2]
    ]
  end
end
