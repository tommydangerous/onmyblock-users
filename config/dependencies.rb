service :metrics_client do |_container|
  Segment::Analytics.new write_key: ENV["SEGMENT_IO_KEY"]
end

factory :resource do |container|
  Resource.new container[:controller]
end
