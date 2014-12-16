class Envelope
  include ActiveModel::Serialization

  attr_reader :errors, :metadata, :resource

  def initialize(opts = {})
    @errors   = opts[:errors]   || {}
    @metadata = add_metadata opts
    @resource = opts[:resource] || {}
  end

  def add_metadata(opts)
    hash = opts[:metadata] || {}
    hash[:execution_time] = Time.now
    hash[:status] = opts[:status] if opts[:status]
    hash
  end
end
