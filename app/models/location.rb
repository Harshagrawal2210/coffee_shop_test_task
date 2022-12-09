# frozen_string_literal: true

class Location < ApplicationRecord
  validates :title, presence: true
  validates :address, presence: true
  validates :url_handle, presence: true, uniqueness: true

  has_many :product_to_locations, dependent: :destroy

  before_save :set_url_handle

  def set_url_handle
    self.url_handle = url_handle.parameterize
  end

  def self.set_interval
    [
      ['10 Minutes', 10],
      ['15 Minutes', 15],
      ['20 Minutes', 20],
      ['30 Minutes', 30]
    ]
  end

  def self.show_location
    Location.all.map { |e| [e.title, e.id] }
  end

  def self.all_location
    Location.order('row_order ASC')
  end

  def self.location_title(id)
    Location.find_by_id(id).title
  end

  def time_slot
    (start_time.to_datetime.to_i..end_time.to_datetime.to_i).step(interval.present? ? interval.to_i.minutes : 10.minutes).map do |e|
      Time.at(e).in_time_zone('America/Phoenix').strftime('%I:%M %p')
    end
  end

  def date_slot(allow_preorder_day)
    start_date = Date.today + allow_preorder_day.to_i
    end_date = start_date + 20
    daysoff = []
    aval_week.to_a.each do |week|
      daysoff << week.to_i
    end
    my_days = daysoff

    result = (start_date..end_date).to_a.select { |k| my_days.include?(k.wday) }
    result.map { |date| date.in_time_zone('America/Phoenix').strftime('%B %d, %Y  (%A)') }
  end
end
