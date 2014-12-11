class CreateService < CrudService
  def process
    if record.save
      @response = serialize
      @status   = 201
    else
      @response = record.errors.to_json
      @status   = 422
    end
  end

  def record
    @record ||= model.new options
  end

  def serialize
    if serializer
      serializer.new record
    else
      record
    end
  end
end
