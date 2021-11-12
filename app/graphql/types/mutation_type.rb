module Types
  class MutationType < Types::BaseObject
    field :create_weather_subscription, mutation: Mutations::CreateWeatherSubscription
    field :cancel_weather_subscription, mutation: Mutations::CancelWeatherSubscription
  end
end
