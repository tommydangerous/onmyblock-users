class CredentialReset
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :credential_id
  field :expires_at, type: DateTime
  field :token,      type: String

  validates_presence_of :credential_id, :expires_at, :token

  belongs_to :credential

  index credential_id: 1
end
