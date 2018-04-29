# frozen_string_literal: true

class Stats::WeeklySerializer < ActiveModel::Serializer
  attributes :total_distance, :total_price

  def total_price
    "#{Trip.sum_price(object)}PLN"
  end

  def total_distance
    "#{Trip.to_km(Trip.sum_distance(object))}KM"
    end
end
