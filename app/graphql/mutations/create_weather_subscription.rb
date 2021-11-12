module Mutations
  class CreateWeatherSubscription < Mutations::BaseMutation
    argument :name, String, required: true
    argument :email, String, required: true
    argument :city, String, required: true

    field :user_weather_subscription, Types::WeatherSubscriptionType, null: true
    field :errors, [String], null: true

    def resolve(name:, email:, city:)
      result = CreateUserWeatherSubscription.call(name: name, email: email, city: city)
      if result.data
        {
          user_weather_subscription: result.data,
          errors: []
        }
      else
        {
          user_weather_subscription: nil,
          errors: []
        }
      end
    end
  end
end
