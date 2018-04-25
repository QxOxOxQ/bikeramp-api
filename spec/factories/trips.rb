# frozen_string_literal: true

FactoryBot.define do
  factory :trip do
    distance { Faker::Number.decimal(2, 2) }
    start { "Plac Europejski 2, Warszawa, Polska" }
    finish { "Bohomolca 15, Warszawa, Polska" }
    date { Faker::Date.between(33.days.ago, Date.today) }
    price { Faker::Number.decimal(2, 2) }
  end
end
