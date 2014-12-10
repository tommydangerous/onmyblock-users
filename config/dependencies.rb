service :metrics_client do |container|
  Segment::Analytics.new write_key: ENV['SEGMENT_IO_KEY']
end
