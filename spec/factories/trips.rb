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

FactoryBot.define do
  factory :current_month_trip, class: "Trip" do
    distance { Faker::Number.number }
    start_address { "Plac Europejski 2, Warszawa, Polska" }
    destination_address { "Bohomolca 15, Warszawa, Polska" }
    date { date }
    price { Faker::Number.decimal(2, 2) }
  end
  factory :current_week_trip, class: "Trip" do
    distance { Faker::Number.decimal(2, 2) }
    date { Faker::Date.between(Date.current.beginning_of_week, Date.yesterday) }
    start_address { "Plac Europejski 2, Warszawa, Polska" }
    destination_address { "Bohomolca 15, Warszawa, Polska" }
    price { Faker::Number.number }

  end
end
