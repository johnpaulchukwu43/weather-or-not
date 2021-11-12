require_relative 'application_interactor'
require_relative '../mailers/weather_subscription_mailer'

class SendWeatherSubscription < ApplicationInteractor
  def call
    puts "fetching subscriptions for notifications"

    active_daily_subscriptions = UserWeatherSubscription.where('created_at >= ?', Time.new.beginning_of_day)
                                                        .where(is_active: true)

    active_daily_subscriptions.all.each do |subscription|
      response = FetchWeather.call(city: subscription.city)
      puts "got weather response#{response}"
      deliver_now = WeatherSubscriptionMailer
                      .with(weather: response.data, subscription: subscription)
                      .subscription_mailer.deliver_now

      puts "send result#{deliver_now}"
    end
  end
end