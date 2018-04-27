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
      begin
        @response = JSON.parse(api_call)
        if status == "OK"
          save_distance!
          return @trip
        else
          raise RestClient::Exception
        end
      rescue RestClient::Exception => restexception
        puts restexception
        return restexception
      rescue Exception => generalexception
        puts generalexception
        return generalexception
      end
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
        "#{@trip.start}\&destinations\=#{@trip.finish}"
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
  end
end
