require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    @street_address_without_spaces = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the variable @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the variable @street_address_without_spaces.
    # ==========================================================================

    # find geo coordinates for address
    url_goog = "http://maps.googleapis.com/maps/api/geocode/json?address="
    lat = JSON.parse(open(url_goog+@street_address_without_spaces).read)["results"][0]["geometry"]["location"]["lat"]
    lng = JSON.parse(open(url_goog+@street_address_without_spaces).read)["results"][0]["geometry"]["location"]["lng"]

    # find weather for geo coordinates
    url_weather = "https://api.darksky.net/forecast/ef11cf1fed20688f4a1169c525bda733/"
    data = JSON.parse(open(url_weather + lat.to_s + "," + lng.to_s).read)

    @current_temperature = data["currently"]["temperature"]

    @current_summary = data["currently"]["summary"]

    @summary_of_next_sixty_minutes = data["minutely"]["summary"]

    @summary_of_next_several_hours = data["hourly"]["summary"]

    @summary_of_next_several_days = data["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
