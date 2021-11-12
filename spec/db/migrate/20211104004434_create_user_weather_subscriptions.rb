class CreateUserWeatherSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :user_weather_subscriptions do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.string :city, null: false
      t.boolean :is_active, null: false

      t.timestamps
    end
  end
end
