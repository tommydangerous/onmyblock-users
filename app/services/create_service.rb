require_relative "crud_service"

class CreateService < CrudService
  def process(condition = nil)
    if condition.nil? && record.save || !condition.nil? && condition
      @response = serialized_record
      @status   = 201
    else
      @response = record_errors
      @status   = 422
    end
  end

  def record
    @record ||= model.new options
  end

  private

  def record_errors
    record.errors
  end

  def serialized_record
    if serializer
      serializer.new record
    else
      record
    end
  end
end
