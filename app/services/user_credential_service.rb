class UserCredentialService < CreateService
  def initialize(options, serializer = nil)
    @options    = options
    @serializer = serializer
  end

  def credential
    @credential ||= build_credential
  end

  def build_credential
    create_credential_service.record
  end

  def build_user
    create_user_service.record
  end

  def process(condition = nil)
    super sign_up_process
  end

  def process_credential
    create_credential_service.process
    create_credential_service.response
  end

  def process_key
    create_key_service.process
    @key_response = create_key_service.response
  end

  def process_user
    create_user_service.process
    create_user_service.response
  end

  def record_valid?(record)
    record.valid?
  end

  def sign_up_process
    if record_valid?(user) && record_valid?(credential)
      process_user
      process_credential
      process_key
    else
      false
    end
  end

  def user
    @user ||= build_user
  end

  private

  def create_credential_service
    @create_credential_service ||= create_service Credential, credential_params
  end

  def create_key_service
    @create_key_service ||= CreateKeyService.new key_params, @serializer
  end

  def create_service(model, opts)
    CreateService.new model, opts
  end

  def create_user_service
    @create_user_service ||= create_service User, options
  end

  def credential_params
    {
      identification: user.email,
      password:       options[:password],
      user_id:        user.id
    }
  end

  def key_params
    { credential_id: credential.id }
  end

  def record_errors
    if !record_valid? user
      errors = user.errors
    elsif !record_valid? credential
      errors = credential.errors
    end
    errors.to_json
  end

  def serialized_record
    @key_response
  end
end
