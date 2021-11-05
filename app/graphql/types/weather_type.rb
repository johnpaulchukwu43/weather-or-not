module Types
  class WeatherType < Types::BaseObject
    field :lon, Float, null: false
    field :lat, Float, null: false
    field :sunrise, String, null: false
    field :sunset, String, null: false
    field :location, String, null: false
  end
end
