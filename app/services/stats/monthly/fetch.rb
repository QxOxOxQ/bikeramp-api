# frozen_string_literal: true

module Stats
  module Monthly
    class Fetch
      def self.call(trips)
        new(trips).call
      end

      def initialize(trips)
        @trips = trips
        @array_of_days = []
        @daily = {}
      end

      def call
        json_monthly_days
      rescue Exception => generalexception
        puts generalexception
        generalexception
      end

      private

        def json_monthly_days
          daily_trips.each do |date, trips_of_day|
            distances = trips_of_day.map(&:distance)
            prices = trips_of_day.map(&:price)
            @array_of_days << {
                day: date.strftime("%B, %eth"),
                total_distance: "#{(distances.sum / 1000).round}km",
                avg_ride: "#{(distances.sum / distances.count / 1000).round}km",
                avg_price: "#{(prices.sum / prices.count).round(2)}PLN"
            }
          end
          @array_of_days
        end

        def daily_trips
          return @daily unless @daily.empty?
          @trips.each do |day|
            if @daily[day.date].present?
              trips_in_one_day = @daily[day.date]
              trips_in_one_day << day
              @daily[day.date] = trips_in_one_day
            else
              @daily[day.date] = [day]
            end
          end
          @daily
        end
    end
  end
end
