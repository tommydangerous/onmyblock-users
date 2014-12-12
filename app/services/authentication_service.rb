class AuthenticationService < CreateService
  def initialize(options, serializer = nil)
    @options    = options
    @serializer = serializer
  end

  def create_key
    service = CreateKeyService.new key_params, @serializer
    service.process
    service.response
  end

  def process
    if valid?
      @response = create_key
      @status   = 201
    else
      @response = errors
      @status   = 422
    end
  end

  def record
    @record ||= Credential.find_by identification: identification
  end

  def valid?
    record && authenticate ? true : false
  end

  private

  def authenticate
    record.authenticate password
  end

  def errors
    {}
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
end
