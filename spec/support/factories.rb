include ActionDispatch::TestProcess

FactoryGirl.define do
  sequence(:email) { Faker::Internet.email }
  sequence(:first_name) { Faker::Name.first_name }
  sequence(:last_name) { Faker::Name.last_name }
  sequence(:password) { Faker::Internet.password 8 }

  factory :credential do
    identification Faker::Internet.email
    password_digest SecureRandom.uuid
    user
  end

  factory :key do
    credential
    expires_at Time.zone.now + 7.days
    token SecureRandom.uuid
  end

  factory :user do
    email
    first_name
    last_name
  end
end
