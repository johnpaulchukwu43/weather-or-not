class WeatherDto
  attr_reader :q, :lon, :lat, :sunrise, :sunset, :location

  def initialize(lon, lat, sunrise, sunset,location)
    @lon = lon
    @lat = lat
    @location = location
    @sunrise = sunrise
    @sunset = sunset
  end
end