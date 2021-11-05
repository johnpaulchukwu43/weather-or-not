module Types
  class MutationType < Types::BaseObject
    field :create_weather_subscription, mutation: Mutations::CreateWeatherSubscriptionMutation
  end
end
