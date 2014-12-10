class CrudService
  pattr_initialize :model, :options

  attr_reader :response, :status
end
