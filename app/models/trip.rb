# frozen_string_literal: true

# == Schema Information
#
# Table name: trips
#
#  id                  :bigint(8)        not null, primary key
#  date                :date             not null
#  destination_address :string           not null
#  distance            :float            default(0.0)
#  price               :float            not null
#  start_address       :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Trip < ApplicationRecord
  validates :destination_address, :start_address, :date, :price, presence: true
  validates :price, numericality: true
  # this gets records without current day
  scope :current_week, -> { where(date: Date.current.beginning_of_week...Date.today).order(:date) }
  scope :current_month, -> { where(date: Date.current.beginning_of_month...Date.current).order(:date) }

  def self.sum_price(trips)
    trips.sum("price")
  end

  def self.sum_distance(trips)
    trips.sum("distance")
  end

  def self.to_km(distance)
    (distance / 1000).round
  end
end
