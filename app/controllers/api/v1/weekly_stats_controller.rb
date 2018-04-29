# frozen_string_literal: true

module Api
  module V1
    class WeeklyStatsController < ApplicationController
      def show
        trips = Trip.current_week
        if trips.empty?
          render json: { error: "TripsDoesNotExistInCurrentWeek" }, status: :not_found
        else
          render json: trips, serializer: Stats::WeeklySerializer, status: :ok
        end
      end
    end
  end
end
