module Types
  class QueryType < Types::BaseObject


    field :weather, Types::WeatherType, null: false do
      argument :city, String, required: true
    end

    field :user_weather_subscription, Types::WeatherSubscriptionType, null: false do
      argument :id, ID, required: true
    end

    field :user_weather_subscriptions, [Types::WeatherSubscriptionType], null: false


    def weather(city:)
      result = FetchWeather.call(city: city)
      result.data
    end

    def user_weather_subscription(id:)
      UserWeatherSubscription.find(id)
    end
  end
end
