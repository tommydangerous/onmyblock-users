class LoginService < CreateService
  def initialize(options, serializer = nil)
    @options    = options
    @serializer = serializer
  end

  def process(_condition = nil)
    super valid? && create_key_service.process
  end

  def record
    @record ||= Credential.find_by identification: identification
  end

  private

  def authenticate
    record.authenticate password
  end

  def create_key_service
    @create_key_service ||= CreateKeyService.new key_params, @serializer
  end

  def identification
    @options[:identification]
  end

  def key_params
    { credential_id: record.id }
  end

  def password
    @options[:password]
  end

  def failure_response
    { authentication_failed: "invalid identification or password" }
  end

  def serialized_record
    create_key_service.response
  end

  def valid?
    record && authenticate ? true : false
  end
end
