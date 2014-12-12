class CrudService
  attr_reader :response, :status

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

  private

  def failure_response
    {}
  end

  def failure_status
    400
  end

  def record_action
  end

  def success_status
    200
  end

  def success_response
    {}
  end
end
