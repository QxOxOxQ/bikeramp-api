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
  factory :trip do
    distance { Faker::Number.decimal(2, 2) }
    start { "Plac Europejski 2, Warszawa, Polska" }
    finish { "Bohomolca 15, Warszawa, Polska" }
    date { Faker::Date.between(33.days.ago, Date.today) }
    price { Faker::Number.decimal(2, 2) }
  end
end
