require_relative "crud_service"

class DeleteService < CrudService
  def process(condition = nil)
    if condition.nil? && record.destroy || !condition.nil? && condition
      @response = {}
      @status   = 204
    else
      @response = {}
      @status   = 422
    end
  end

  def record
    @record ||= model.find options[:id]
  end
end
