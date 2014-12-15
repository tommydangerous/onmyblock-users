require_relative "crud_service"

class UpdateService < CrudService
  def initialize(model, record_id, options, serializer = nil)
    @model      = model
    @record_id  = record_id
    @options    = options
    @serializer = serializer
  end

  attr_private :record_id

  def record
    @record ||= model.find record_id
  end

  private

  def failure_response
    record ? record.errors : "not found"
  end

  def record_action
    record.update(**options) if record
  end
end
