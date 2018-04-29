# encoding: utf-8
# frozen_string_literal: true

module GoogleMatrixApiClient
  class Fetch
    require "rest-client"

    def self.call(trip)
      new(trip).call
    end

    def initialize(trip)
      @trip = trip
    end

    def call
      @response = JSON.parse(api_call)
      if status == "OK"
        save_distance!
        return @trip
      else
        return google_error_message(status)
      end
    rescue URI::InvalidURIError => uri_error
      puts uri_error
      uri_error_message
    rescue RestClient::Exception => restexception
      puts restexception
      restexception
    end

    private


      def api_call
        RestClient.get(url)
      end

      def url
        "https://maps.googleapis.com/maps/api/distancematrix/json?units=metric" +
            "&origins=#{origins}" +
            "&mode=#{mode}" +
            "&language=#{language}" +
            "&key=#{key}"
      end

      def mode
        "bicycling"
      end

      def language
        "pl-PL"
      end

      def origins
        "#{@trip.start_address}\&destinations\=#{@trip.destination_address}"
      end

      def key
        ENV["Google_Maps_Distance_Matrix_API"]
      end

      def distance
        @response["rows"][0]["elements"][0]["distance"]["value"]
      end

      def status
        @response["rows"][0]["elements"][0]["status"]
      end

      def save_distance!
        @trip.update!(distance: distance)
      end

      def google_error_message(error)
        { error: {
            "Response from google API": error,
            trip: @trip }
        }
      end

      def uri_error_message
        { error: {
            error: 'user only ASCII characters, (without special char for instance: "ŃĄŚ")',
            trip: @trip }
        }
      end
  end
end
