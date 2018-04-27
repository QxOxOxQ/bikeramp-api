# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Trips API", type: :request do

  describe "GET api/stats/weekly" do
    before { get "api/stats/weekly" }
    context "when the records exists" do
      it "returns weekly stats" do
        expect(json).not_to be_empty
        expect(json.size).to eq(1)
      end
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end

    context "when the records does not exist" do

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
      it "returns a not found massage" do
        expect(response.body).to match(/Couldn't find stats for last week/)
      end
    end
  end
  describe "GET api/stats/monthly" do
    before { get "api/stats/monthly" }
    it "returns daily stats" do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end
  describe "POST api/stats/monthly" do
    let(:price) { Faker::Number.decimal(2, 2) }
    let(:start) { "Plac Europejski 2, Warszawa, Polska" }
    let(:finish) { "Bohomolca 15, Warszawa, Polska" }
    let(:date) { Faker::Date.forward(23) }

    let(:valid_attributes) {}
    context "when the request is valid" do
      before { post "api/trips", params: valid_attributes }

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end
    let(:invalid_attributes) {}
    context "when the request is invalid" do
      before { post "api/trips", params: invalid_attributes }
      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end
      it "returns a validation failure message" do
        expect(response.body)
            .to match(/Validation failed: Created by can't be blank/)
      end
    end
  end
end
