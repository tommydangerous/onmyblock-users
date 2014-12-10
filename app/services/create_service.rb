class CreateService < CrudService
  def process
    if record.new_record?
      @response = record.errors
      @status   = 422
    else
      @response = record
      @status   = 201
    end
  end

  def record
    @record ||= model.create options
  end
end
