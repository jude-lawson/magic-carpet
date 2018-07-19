FactoryBot.define do
  factory :user do
    lyft_id Faker::Name.name
    lyft_token Faker::Crypto.sha1
    lyft_refresh_token Faker::Crypto.sha1
    first_name Faker::Name.name
    last_name  Faker::Name.name
  end
end
