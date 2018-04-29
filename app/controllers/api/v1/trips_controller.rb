# frozen_string_literal: true

module Api
  module V1
    class TripsController < ApplicationController
      def create
        trip = Trip.new(trip_params)
        return render json: trip.errors, status: :unprocessable_entity unless trip.valid?
        service = GoogleMatrixApiClient::Fetch.call(trip)
        if service.class == Trip
          render json: service, status: :created
        else
          render json: service, status: :unprocessable_entity
        end
      end

      private
        def trip_params
          params.permit(:start_address, :destination_address, :price, :date)
        end
    end
  end
end
