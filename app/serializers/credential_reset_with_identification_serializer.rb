class CredentialResetWithIdentificationSerializer < ActiveModel::Serializer
  attributes :id, :expires_at

  def expires_at
    credential_reset.try :expires_at
  end

  def id
    credential_reset.try(:id).try :to_s
  end

  private

  def credential_reset
    object.credential_reset
  end
end
