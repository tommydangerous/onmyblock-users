class Authentication
  attr_reader :identification

  def initialize(identification: nil, password: nil)
    @identification = identification
    @password       = password
  end

  def credential
    @credential ||= Credential.find_by identification: @identification
  end

  def destroy
    # logout
  end

  def errors
    # @errors
  end

  def save
    # if valid?
    #   # create key
    # else
    #   # set errors
    # end
  end

  def valid?
    # find credential, authenticate it
    if credential && authenticate
      true
    else
      false
    end
  end

  private

  def authenticate
    credential.authenticate @password
  end
end
