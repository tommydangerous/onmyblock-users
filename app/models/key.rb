class Key < BaseModel
  TYPES = {
    access: "access",
    reset:  "reset"
  }.freeze

  field :credential_id
  field :expires_at,   type: DateTime
  field :token,        type: String
  field :type,         type: String, default: TYPES[:access]

  validates :type, inclusion: { in: TYPES.values }
  validates_presence_of :credential_id, :expires_at, :token
  validates_uniqueness_of :token, case_sensitive: false

  belongs_to :credential

  index({ credential_id: 1 })

  def self.generate_access_token
    SecureRandom.uuid
  end

  def assign_token(t)
    self.token = t
  end
end
