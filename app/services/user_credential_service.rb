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

  def process
    # !!!
  end

  def record_valid?(record)
    record.valid?
  end

  def save_credential
    create_credential_service.process
    {
      response: create_credential_service.response,
      status:   create_credential_service.status
    }
  end

  def save_credential_from_user
    set_credential_to_user
    save_credential
  end

  def save_key_from_credential
    create_key_service.process
    {
      response: create_key_service.response,
      status:   create_key_service.status
    }
  end

  def save_user
    create_user_service.process
    {
      response: create_user_service.response,
      status:   create_user_service.status
    }
  end

  def sign_up_process
    # 1. build user
    # 2. validate user
    # 3. build credential
    # 4. validate credential
    if record_valid?(user) && record_valid?(credential)
      # 5. save user
      save_user
      # 6. save credential from user
      save_credential_from_user
      # 7. create key from credential
      save_key_from_credential
    end
  end

  def set_credential_to_user
    credential.user = user
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
