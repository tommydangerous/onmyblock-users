require_relative "service"

class CrudService < Service
  attr_reader :record

  def initialize(model, options, serializer = nil)
    @model      = model
    @options    = options
    @serializer = serializer
  end

  attr_private :model, :serializer

  def process(condition = nil)
    success = condition.nil? && record_action || !condition.nil? && condition
    set_response success
    success
  end

  private

  def failure_response
    nil
  end

  def record_action
    record
  end

  def serialized_record
    serializer ? serializer.new(record) : record
  end

  def set_response(condition)
    @response = send "#{(condition ? "success" : "failure")}_response"
  end

  def success_response
    serialized_record
  end
end
