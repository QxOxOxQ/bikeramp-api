# frozen_string_literal: true

require "rails_helper"

RSpec.describe Stats::Monthly::Fetch, type: :service do

  before { Timecop.freeze(Date.current.beginning_of_month + 15.day) }
  let!(:trip4) { FactoryBot.create(:current_month_trip, date: Date.current.last_month, distance: 9000, price: 1015) }
  let!(:trip3) { FactoryBot.create(:current_month_trip, date: Date.current - 5.days, distance: 6000, price: 150) }
  let!(:trip1) { FactoryBot.create(:current_month_trip, date: Date.current - 1.days, distance: 3500, price: 1.5) }
  let!(:trip2) { FactoryBot.create(:current_month_trip, date: Date.current - 1.days, distance: 1000, price: 30) }
  let!(:trip2) { FactoryBot.create(:current_month_trip, date: Date.current - 1.days, distance: 0, price: 200) }
  let!(:trip5) { FactoryBot.create(:current_month_trip, date: Date.today, distance: 7000, price: 1999) }
  let!(:trips) { [trip1, trip2, trip3, trip4, trip5] }
  let(:expected_response_json) {
    [{ day: "May, 15th", total_distance: "4km", avg_ride: "2km", avg_price: "100.75PLN" },
     { day: "May, 11th", total_distance: "6km", avg_ride: "6km", avg_price: "150.0PLN" },
     { day: "April, 16th", total_distance: "9km", avg_ride: "9km", avg_price: "1015.0PLN" },
     { day: "May, 16th", total_distance: "7km", avg_ride: "7km", avg_price: "1999.0PLN" }]
  }
  describe ".call" do
    let!(:service)  { Stats::Monthly::Fetch.call(trips) }
    it("fetch stats") { expect(service).to eq(expected_response_json) }
  end
end
