class CreateUserWeatherSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :user_weather_subscriptions do |t|
      t.string :email
      t.string :name
      t.string :city

      t.timestamps
    end
  end
end
