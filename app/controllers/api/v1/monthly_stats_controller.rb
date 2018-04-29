# frozen_string_literal: true

module Api
  module V1
    class MonthlyStatsController < ApplicationController
      def show
        trips = Trip.current_month
        if trips.empty?
          render json: { error: "TripsDoesNotExistInCurrentMonth" }, status: :not_found
        else
          render json: Stats::Monthly::Fetch.call(trips), status: :ok
        end
      end
    end
  end
end
