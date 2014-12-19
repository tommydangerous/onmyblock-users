class CreateKeyService < CreateService
  def initialize(options, serializer = nil)
    @model      = Key
    @options    = options
    @serializer = serializer
  end

  def record
    if @record.nil?
      @record = model.new options
      configure_defaults
    end
    @record
  end

  private

  def configure_defaults
    @record.configure_defaults
  end
end
