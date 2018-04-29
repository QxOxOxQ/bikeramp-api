# frozen_string_literal: true

class Stats::WeeklySerializer < ActiveModel::Serializer
  attributes :total_distance, :total_price

  def total_price
    "#{object.sum("price")}PLN"
  end

  def total_distance
    "#{(object.sum("distance") / 1000).round}KM"
  end
end
