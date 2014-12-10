include ActionDispatch::TestProcess

FactoryGirl.define do
  sequence(:email) { Faker::Internet.email }
  sequence(:first_name) { Faker::Name.first_name }
  sequence(:last_name) { Faker::Name.last_name }
  sequence(:password) { Faker::Internet.password 8 }

  factory :key do
    expires_at Time.zone.now + 7.days
    token SecureRandom.uuid
  end

  factory :user do
    email
    first_name
    last_name
  end
end
