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


FactoryBot.define do
  factory :current_month_trip, class: "Trip" do
    distance { Faker::Number.number }
    start { "Plac Europejski 2, Warszawa, Polska" }
    date { Faker::Date.between(Date.current.beginning_of_month, Date.yesterday) }
    finish { "Bohomolca 15, Warszawa, Polska" }
    price { Faker::Number.decimal(2, 2) }
  end
  factory :current_week_trip, class: "Trip" do
    distance { Faker::Number.decimal(2, 2) }
    date { Faker::Date.between(Date.current.beginning_of_week, Date.yesterday) }
    start { "Plac Europejski 2, Warszawa, Polska" }
    finish { "Bohomolca 15, Warszawa, Polska" }
    price { Faker::Number.number }

  end
end
