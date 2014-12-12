class UserCredentialService < CrudService
  def initialize(options, serializer = nil)
    @options    = options
    @serializer = serializer
  end

  def build_credential
    create_credential_service(credential_params).record
  end

  def build_user
    create_user_service(options).record
  end

  def create_credential_service(opts)
    create_service Credential, opts
  end

  def create_user_service(opts)
    create_service User, opts
  end

  def process
    # 1. build user
    # 2. validate user
    # 3. build credential
    # 4. validate credential
    # 5. save user
    # 6. save credential
  end

  private

  def create_service(model, opts)
    CreateService.new model, opts
  end

  def credential_params
    {
      identification: options[:email],
      password:       options[:password]
    }
  end
end
