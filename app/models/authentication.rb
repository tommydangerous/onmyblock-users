class Session
  # attr_reader :response, :status

  def credential
    Credential.find
  end

  def destroy
    # logout
  end

  def errors
    @errors
  end

  def initialize(identification, password_digest)
    @identification  = identification
    @password_digest = password_digest
  end

  def save
    if valid?
      # create key
    else
      # set errors
    end
  end

  def valid?
    # find credential, authenticate it
  end
end
