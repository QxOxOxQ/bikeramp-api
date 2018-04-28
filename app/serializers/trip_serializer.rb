# frozen_string_literal: true

class TripSerializer < ActiveModel::Serializer
  attributes :start_address, :destination_address, :price,
             :distance, :date

  def start_address
    object.start
  end

  def destination_address
    object.finish
  end

  def distance
    "#{(object.distance / 1000).round}km"
  end

  def price
    "#{object.price}PLN"
  end
end
