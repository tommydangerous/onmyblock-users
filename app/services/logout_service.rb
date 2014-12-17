class LogoutService < CrudService
  def initialize(options, serializer = nil)
    @options    = options
    @serializer = serializer
  end

  def process(_condition = nil)
    super find_and_delete
  end

  private

  def delete_service
    @delete_service ||= DeleteService.new Key, id: key_id
  end

  def find_and_delete
    read_service.response && delete_service.response
  end

  def key_id
    key ? key.id : ""
  end

  def success_response
    {}
  end
end
