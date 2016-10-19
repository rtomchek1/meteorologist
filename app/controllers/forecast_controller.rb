require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    url = "https://api.darksky.net/forecast/ef11cf1fed20688f4a1169c525bda733/"
    data = JSON.parse(open(url + @lat + "," + @lng).read)

    @current_temperature = data["currently"]["temperature"]

    @current_summary = data["currently"]["summary"]

    @summary_of_next_sixty_minutes = data["minutely"]["summary"]

    @summary_of_next_several_hours = data["hourly"]["summary"]

    @summary_of_next_several_days = data["daily"]["summary"]

    render("forecast/coords_to_weather.html.erb")
  end
end
