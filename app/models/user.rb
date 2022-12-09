# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders, dependent: :destroy
  validates :name, :mobile, presence: true

  def show_name
    user = name.split(' ')
    str = ''
    user.count.times do |i|
      str += "#{user[i]} ".capitalize
    end
    str
  end

  def timezone
    'America/Phoenix'
  end
end
