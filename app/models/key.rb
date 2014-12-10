class Key < BaseModel
  field :expires_at, type: DateTime
  field :token,      type: String

  belongs_to :credential

  validates_presence_of :expires_at, :token
  validates_uniqueness_of :token, case_sensitive: false
end
