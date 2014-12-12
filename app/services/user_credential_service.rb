class UserCredentialService < CrudService
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

  def record_valid?(record)
    record.valid?
  end

  def save_credential
    create_credential_service.process
    create_credential_service.response
  end

  def save_credential_from_user
    set_credential_to_user
    save_credential
  end

  def save_user
    create_user_service.process
    create_user_service.response
  end

  def set_credential_to_user
    credential.user = user
  end

  def user
    @user ||= build_user
  end

  def process
    # 1. build user
    # 2. validate user
    # 3. build credential
    # 4. validate credential
    # 5. save user
    # 6. save credential from user
    # 7. create key from credential
  end

  private

  def create_credential_service
    @create_credential_service ||= create_service Credential, credential_params
  end

  def create_service(model, opts)
    CreateService.new model, opts
  end

  def create_user_service
    @create_user_service ||= create_service User, options
  end

  def credential_params
    {
      identification: options[:email],
      password:       options[:password]
    }
  end
end
