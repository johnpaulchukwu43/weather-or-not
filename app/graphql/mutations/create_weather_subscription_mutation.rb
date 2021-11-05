module Mutations
  class CreateWeatherSubscriptionMutation < Mutations::BaseMutation
    argument :name, String, required: true
    argument :email, String, required: true
    argument :city, String, required: true

    field :subscriber, Types::WeatherSubscriptionType, null: false
    field :errors, [String], null: false

    def resolve(name:, email:, city:)
      result = CreateUserWeatherSubscription.call(name: name, email: email, city: city)
      result.data
    end

  end
end
