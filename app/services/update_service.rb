require_relative "crud_service"

class UpdateService < CrudService
  def record
    @record ||= model.find options[:id]
  end

  private

  def failure_response
    record ? record.errors : "not found"
  end

  def record_action
    record.update(**options.except(:id)) if record
  end
end
