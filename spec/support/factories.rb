include ActionDispatch::TestProcess

FactoryGirl.define do
  sequence(:email)      { Faker::Internet.email }
  sequence(:first_name) { Faker::Name.first_name }
  sequence(:last_name)  { Faker::Name.last_name }
  sequence(:password)   { Faker::Internet.password 8 }
  sequence(:phone_number)   { Faker::PhoneNumber.phone_number }

  factory :credential do
    identification { user.email }
    password { SecureRandom.uuid }
    user
  end

  factory :credential_reset do
    credential
    expires_at Time.zone.now + 3.days
    token { SecureRandom.uuid }
  end

  factory :key do
    credential
    expires_at Time.zone.now + 7.days
    token { SecureRandom.uuid }
  end

  factory :user do
    email
    first_name
    last_name
  end
end
