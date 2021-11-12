class CreateUserWeatherSubscription < ApplicationInteractor

  parameters :name, :email, :city

  def call
    user_weather_subscription = UserWeatherSubscription.new(email: email, name: name, city: city, is_active: true)

    if user_weather_subscription.save
      context.data = user_weather_subscription
      context.errors = []
    else
      context.data = nil
      context.errors = user_weather_subscription.errors.full_messages
    end
  end
end
