class CrudService < Service
  def initialize(model, options, serializer = nil)
    @model      = model
    @options    = options
    @serializer = serializer
  end
  
  attr_private :model, :options, :serializer

  def process(condition = nil)
    if condition.nil? && record_action || !condition.nil? && condition
      @response = success_response
      @status   = success_status
    else
      @response = failure_response
      @status   = failure_status
    end
  end

  def record
    @record
  end

  def serialized_record
    serializer ? serializer.new(record) : record
  end

  private

  def failure_response
    nil
  end

  def failure_status
    400
  end

  def record_action
    record
  end

  def success_status
    200
  end

  def success_response
    serialized_record
  end
end
