# frozen_string_literal: true

# == Schema Information
#
# Table name: trips
#
#  id         :bigint(8)        not null, primary key
#  distance   :float
#  price      :float            not null
#  date       :date             not null
#  start      :string           not null
#  finish     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class Trip < ApplicationRecord
  validates_presence_of :finish, :start, :date, :price
  # this gets records without current day
  scope :current_week, -> { where(date: Date.current.beginning_of_week...Date.today).order(:date) }
  scope :current_month, -> { where(date: Date.current.beginning_of_month...Date.current).order(:date) }
end
