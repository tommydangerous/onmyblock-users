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

service :users do
  User
end

factory :user do |container|
  container[:users].new container[:attributes]
end

factory :user_serializer do |container|
  UserSerializer.new container[:record]
end
