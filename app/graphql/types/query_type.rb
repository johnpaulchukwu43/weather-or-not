module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :weather, Types::WeatherType, null: false do
      argument :city, String, required: true
    end

    def weather(city:)
      result = FetchWeather.call(city: city)
      result.data
    end
  end
end
