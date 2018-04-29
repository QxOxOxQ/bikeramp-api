# frozen_string_literal: true

# == Schema Information
#
# Table name: trips
#
#  id                  :bigint(8)        not null, primary key
#  date                :date             not null
#  destination_address :string           not null
#  distance            :float
#  price               :float            not null
#  start_address       :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#


class TripSerializer < ActiveModel::Serializer
  attributes :start_address, :destination_address, :price,
             :distance, :date

  def start_address
    object.start_address
  end

  def destination_address
    object.destination_address
  end

  def distance
    "#{(object.distance / 1000).round}km"
  end

  def price
    "#{object.price}PLN"
  end
end
