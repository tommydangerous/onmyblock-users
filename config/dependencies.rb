factory :resource do |container|
  Resource.new container[:controller]
end

service :metrics_client do |_container|
  Segment::Analytics.new write_key: ENV["SEGMENT_IO_KEY"]
end

service :authentications do
  Authentication
end

factory :authentication do |container|
  container[:authentications].new container[:attributes]
end

factory :authentication_serializer do |container|
  AuthenticationSerializer.new container[:record]
end

service :credentials do
  Credential
end

factory :credential do |container|
  container[:credentials].new container[:attributes]
end

service :credential_resets do
  CredentialResetWithIdentification
end

factory :credential_reset do |container|
  container[:credential_resets].new container[:attributes]
end

factory :credential_reset_serializer do |container|
  CredentialResetWithIdentificationSerializer.new container[:record]
end

service :credential_update_from_resets do |container|
  CredentialUpdateFromReset
end

factory :credential_update_from_reset do |container|
  container[:credential_update_from_resets].new container[:attributes]
end

service :users do
  User
end

factory :user do |container|
  container[:users].new container[:attributes]
end

factory :user_serializer do |container|
  UserSerializer.new container[:record]
end
