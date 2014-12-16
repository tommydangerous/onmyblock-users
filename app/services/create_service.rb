require_relative "crud_service"

class CreateService < CrudService
  def record
    @record ||= model.new options
  end

  private

  def failure_response
    record.errors
  end

  def record_action
    record.save
  end
end
