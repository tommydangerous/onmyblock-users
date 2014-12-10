class CreateService < CrudService
  def process
    if record.new_record?
      @response = record.errors
      @status   = 422
    else
      @response = serialize
      @status   = 201
    end
  end

  def record
    @record ||= model.create options
  end

  def serialize
    if serializer
      serializer.new record
    else
      record
    end
  end
end
