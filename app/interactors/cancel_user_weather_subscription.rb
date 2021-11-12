class CancelUserWeatherSubscription < ApplicationInteractor

  parameters :id

  def call

    result = UserWeatherSubscription.update(id, :is_active => false)

    if result
      puts("destroyed#{result}")
      context.data = result
      context.errors = []
    else
      context.data = nil
      context.errors = "Unable to cancel subscription"
    end
  end
end
