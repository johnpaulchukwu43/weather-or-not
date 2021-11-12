module Mutations
  class CancelWeatherSubscription < Mutations::BaseMutation
    argument :id, Integer , required: true

    field :user_weather_subscription, Types::WeatherSubscriptionType, null: true
    field :errors, [String], null: true

    def resolve(id:)
      result = CancelUserWeatherSubscription.call(id: id)
      if result.data
        {
          user_weather_subscription: result.data,
          errors: []
        }
      else
        {
          user_weather_subscription: nil,
          errors: result.errors
        }
      end
    end
  end
end