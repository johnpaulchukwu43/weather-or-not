#
require 'clockwork'
require 'active_support/time'

require './config/boot'
require './config/environment'

module Clockwork

  every(1.day, 'WeatherSubscriptionJob', at: '00:00') do
    puts "running weather subscription job.."
    WeatherSubscriptionJob.perform_now
  end
end
