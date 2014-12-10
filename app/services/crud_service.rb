class CrudService
  attr_reader :response, :status

  def initialize(model, options, serializer = nil)
    @model      = model
    @options    = options
    @serializer = serializer
  end
  
  attr_private :model, :options, :serializer
end
