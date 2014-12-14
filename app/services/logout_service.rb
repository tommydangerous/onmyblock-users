class LogoutService < CrudService
  def initialize(options, serializer = nil)
    @options    = options
    @serializer = serializer
  end

  def process(condition = nil)
    super find_and_delete
  end

  private

  def delete_service
    unless @delete_service
      @delete_service = DeleteService.new Key, { id: key_id }
      @delete_service.process
    end
    @delete_service
  end

  def failure_status
    if key.nil?
      read_service.status
    else
      delete_service.status
    end
  end

  def find_and_delete
    read_service.response && delete_service.response
  end

  def key
    @key ||= read_service.response
  end

  def key_id
    key ? key.id : ""
  end

  def read_service
    unless @read_service
      @read_service = ReadService.new Key, { token: options[:token] }
      @read_service.process
    end
    @read_service
  end

  def success_response
    {}
  end
end
