# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Trips API", type: :request do
  describe "GET /api/stats/weekly" do
    context "when the records exists" do
      Timecop.freeze(Date.current.beginning_of_week + 1.day)
      let!(:trips) { FactoryBot.create_list(:current_week_trip, 4) }
      before do
        get "/api/stats/weekly"
      end
      it "returns weekly stats" do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)
        expect(json["total_distance"]).to_not eq(nil)
        expect(json["total_price"]).to_not eq(nil)
      end
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
      context "when is first day of week" do
        before do
          Timecop.freeze(Date.current.beginning_of_week)
          get "/api/stats/weekly"
        end
        it "returns status code 404" do
          expect(response).to have_http_status(404)
        end
        it "returns a not found massage" do
          expect(response.body).to match(/TripsDoesNotExistInCurrentWeek/)
        end
      end
    end

    context "when the records does not exist" do
      before do
        Timecop.freeze(Date.current.beginning_of_week + 1.day)
        get "/api/stats/weekly"
      end

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
      it "returns a not found massage" do
        expect(response.body).to match(/TripsDoesNotExistInCurrentWeek/)
      end
    end
  end
  describe "GET /api/stats/monthly" do
    context "when the records exists" do

      Timecop.freeze(Date.current.beginning_of_month + 15.day)
      let!(:trip1) { FactoryBot.create(:current_month_trip, date: Date.yesterday) }
      let!(:trip2) { FactoryBot.create(:current_month_trip, date: Date.yesterday) }
      let!(:trip3) { FactoryBot.create(:current_month_trip, date: Date.current - 5.days) }
      let!(:trip4) { FactoryBot.create(:current_month_trip, date: Date.current.last_month) }
      let!(:trip5) { FactoryBot.create(:current_month_trip, date: Date.current) }

      before do
        get "/api/stats/monthly"
      end
      it "returns daily stats" do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
      context "when is first day of month" do
        before do
          Timecop.freeze(Date.current.beginning_of_month)
          get "/api/stats/monthly"
        end
        it "returns status code 404" do
          expect(response).to have_http_status(404)
        end
        it "returns a not found massage" do
          expect(response.body).to match(/TripsDoesNotExistInCurrentMonth/)
        end
      end
    end

    context "when the records does not exist" do
      before { get "/api/stats/monthly" }
      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
      it "returns a not found massage" do
        expect(response.body).to match(/TripsDoesNotExistInCurrentMonth/)
      end
    end
  end
  describe "POST /api/stats/monthly" do
    let(:price) { Faker::Number.decimal(2, 2) }
    let(:start_address) { "Plac Europejski 2, Warszawa, Polska" }
    let(:destination_address) { "Bohomolca 15, Warszawa, Polska" }
    let(:date) { Faker::Date.forward(23) }

    context "when the request is valid" do
      let!(:valid_attributes) { {
          price: price,
          start_address: start_address,
          destination_address: destination_address,
          date: date }}
      before { post "/api/trips", params: valid_attributes }
      it "returns trip object" do
        expect(json).not_to be_empty
        expect(json.size).to eq(5)
        expect(json["price"]).to eq("#{price}PLN")
        expect(json["start_address"]).to eq(start_address)
        expect(json["destination_address"]).to eq(destination_address)
        expect(json["distance"]).to_not eq(nil)
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end
    context "when the request is invalid" do
      let(:start_address) { "" }
      let!(:invalid_attributes) { {
          price: price,
          start_address: start_address,
          destination_address: destination_address,
          date: date }}
      before { post "/api/trips", params: invalid_attributes }
      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end
      it "returns a validation failure message" do
        expect(response.body)
            .to match("{\"start_address\":[\"can't be blank\"]}")
      end
    end
  end
end
