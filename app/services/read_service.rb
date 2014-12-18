require_relative "crud_service"

class ReadService < CrudService
  def record
    @record || model.find_by(**options)
  end

  private

  def failure_response
    { not_found: "record was not found" }
  end
end
