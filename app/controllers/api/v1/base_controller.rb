class Api::V1::BaseController < ApiController
  def create
    render json: create_service.response
  end

  private

  def create_service
    if @create_service.nil?
      @create_service = create_service_new
      @create_service.process if @create_service
    end
    @create_service
  end

  def create_service_new
    # Override this
  end

  def delete_service(model, options, serializer = nil)
    service "delete", model, options, serializer
  end

  def read_service(model, options, serializer = nil)
    service "read", model, options, serializer
  end

  def service(action, model, options, serializer)
    name = "#{action}_service"
    ivar = "@#{name}"
    if instance_variable_get(ivar).nil?
      instance_variable_set ivar,
                            Object.const_get(name.camelize).new(model, options, serializer)
      instance_variable_get(ivar).process if instance_variable_get(ivar)
    end
    instance_variable_get ivar
  end
end
