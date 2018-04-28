# frozen_string_literal: true

module Api
  module V1
    class TripsController < ApplicationController
      def weekly_stats
        trips = Trip.current_week
        if trips.empty?
          render json: { error: "TripsDoesNotExistInCurrentWeek" }, status: :not_found
        else
          render json: trips, serializer: Stats::WeeklySerializer, status: :ok
        end
      end


      def monthly_stats
        trips = Trip.current_month
        if trips.empty?
          render json: { error: "TripsDoesNotExistInCurrentMonth" }, status: :not_found
        else
          render json: Stats::Monthly::Fetch.call(trips), status: :ok
        end
      end

      def create
      end
    end
  end
end
