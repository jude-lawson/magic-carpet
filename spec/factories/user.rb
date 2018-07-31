FactoryBot.define do
  factory :user do
    ride_count Faker::Number.number(2)
  end
end
