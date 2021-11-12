class WeatherSubscriptionMailer < ApplicationMailer
  def subscription_mailer

    @subscription = params[:subscription]
    @weather = params[:weather]

    mail(to: @subscription.email,
         subject: 'Your daily weather update',
         template_path: '../views/weather_subscription_mailer'
    )
  end
end
