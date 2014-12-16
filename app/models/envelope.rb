class Envelope
  attr_reader :errors, :metadata, :resource

  def initialize(opts = {})
    @errors   = opts[:errors]   || {}
    @metadata = opts[:metadata] || {}
    @resource = opts[:resource] || {}
  end

  def as_json(opts = {})
    {
      resource: resource,
      metadata: metadata,
      errors:   errors
    }
  end
end
