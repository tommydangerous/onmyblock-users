require_relative "crud_service"

class DeleteService < CrudService
  def record
    @record ||= model.find options[:id]
  end

  private

  def failure_response
    {}
  end

  def failure_status
    422
  end

  def record_action
    record.try(:destroy) if record
  end

  def success_status
    204
  end

  def success_response
    {}
  end
end
