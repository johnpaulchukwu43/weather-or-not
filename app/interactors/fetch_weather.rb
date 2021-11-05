require_relative '../models/dtos/weather_dto'

class FetchWeather < ApplicationInteractor
  include HTTParty

  parameters :city

  def open_weather_api_key
    ENV['OPEN_WEATHER_API_KEY']
  end

  def open_weather_url
    ENV['OPEN_WEATHER_URL']
  end

  # @return [WeatherDto, String]
  def call
    handle_timeouts do
      response = HTTParty.get(open_weather_url, query: { q: city, appid: open_weather_api_key }, format: :json)
      if response['cod'] == 200
        context.status = Constant::SUCCESS_STATUS
        context.data = WeatherDto.new(
          response['coord']['lon'], response['coord']['lat'],
          response['sys']['sunrise'], response['sys']['sunset'],
          response['name']
        )
      else
        puts 'No entry found'
        context.status = Constant::FAIL_STATUS
        context.data = WeatherDto.new(nil, nil, nil, nil, nil)
      end
    end
  end

  def handle_timeouts
    yield
  rescue Net::OpenTimeout, Net::ReadTimeout => e
    puts e.message
    fail!('Error occurred while fetching weather information')
  end
end
