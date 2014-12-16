class Envelope
  include ActiveModel::Serialization
  
  attr_reader :errors, :metadata, :resource

  def initialize(opts = {})
    @errors   = opts[:errors]   || {}
    @metadata = opts[:metadata] || {}
    @resource = opts[:resource] || {}
  end
end
