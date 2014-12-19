require_relative "crud_service"

class DeleteService < CrudService
  def record
    @record ||= model.find options[:id]
  end

  private

  def record_action
    record.try(:destroy) if record
  end

  def success_response
    {}
  end
end
