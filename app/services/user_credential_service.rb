class UserCredentialService < CrudService
  def initialize(options, serializer = nil)
    @options    = options
    @serializer = serializer
  end

  def create_credential_service(options)
    create_service Credential, options
  end

  def create_service(model, options)
    CreateService.new model, options
  end

  def create_user_service(options)
    create_service User, options
  end
end
