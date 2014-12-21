service :users do
  User
end

factory :user do |container|
  container[:users].new container[:attributes]
end

factory :user_serializer do |container|
  UserSerializer.new container[:record]
end

factory :resource do |container|
  Resource.new container[:controller]
end

service :metrics_client do |_container|
  Segment::Analytics.new write_key: ENV["SEGMENT_IO_KEY"]
end
