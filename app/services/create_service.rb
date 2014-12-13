require_relative "crud_service"

class CreateService < CrudService
  def record
    @record ||= model.new options
  end

  private

  def failure_response
    record.errors
  end

  def failure_status
    422
  end

  def record_action
    record.save
  end

  def success_status
    201
  end

  def success_response
    serialized_record
  end
end
