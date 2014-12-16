require_relative "crud_service"

class ReadService < CrudService
  def record
    @record || model.find_by(**options)
  end

  private

  def failure_status
    404
  end
end
