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

  def errors_response
    if !record_valid? user
      errors = user.errors
    elsif !record_valid? credential
      errors = credential.errors
    end
    { response: errors.to_json, status: 422 }
  end

  def process
    hash      = sign_up_process
    @response = hash[:response]
    @status   = hash[:status]
  end

  def process_credential
    create_credential_service.process
    {
      response: create_credential_service.response,
      status:   create_credential_service.status
    }
  end

  def process_key
    create_key_service.process
    {
      response: create_key_service.response,
      status:   create_key_service.status
    }
  end

  def process_user
    create_user_service.process
    {
      response: create_user_service.response,
      status:   create_user_service.status
    }
  end

  def record_valid?(record)
    record.valid?
  end

  def sign_up_process
    # 1. build user
    # 2. validate user
    # 3. build credential
    # 4. validate credential
    if record_valid?(user) && record_valid?(credential)
      # 5. save user
      process_user
      # 6. save credential from user
      process_credential
      # 7. create key from credential
      process_key
    else
      errors_response
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
end
