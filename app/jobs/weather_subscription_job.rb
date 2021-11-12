require_relative '../interactors/send_weather_subscription'
require_relative 'application_job'
#
require 'sidekiq'

class WeatherSubscriptionJob < ApplicationJob
  queue_as :medium

  def perform
    SendWeatherSubscription.call!
  end
end
