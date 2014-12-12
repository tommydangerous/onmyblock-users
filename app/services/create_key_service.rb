class CreateKeyService < CreateService
  def initialize(options, serializer = nil)
    @model      = Key
    @options    = options
    @serializer = serializer
  end

  def record
    if @record.nil?
      @record = model.new options
      assign_expires_at
      assign_token
    end
    @record
  end

  private

  def assign_expires_at
    @record.assign_expires_at
  end

  def assign_token
    @record.assign_token
  end
end
