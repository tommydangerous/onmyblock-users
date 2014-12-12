class Key < BaseModel
  DEFAULT_DAYS       = 3
  DEFAULT_EXPIRES_AT = Time.zone.now + DEFAULT_DAYS.days
  TYPES = {
    access: "access",
    reset:  "reset"
  }.freeze

  field :credential_id
  field :expires_at,   type: DateTime
  field :token,        type: String
  field :type,         type: String, default: TYPES[:access]

  validates :type, inclusion: { in: TYPES.values }
  validates_presence_of :credential_id, :expires_at, :token, :type
  validates_uniqueness_of :token, case_sensitive: false

  belongs_to :credential

  index({ credential_id: 1 })
  index({ token: 1 })

  def self.generate_access_token
    SecureRandom.uuid
  end

  def assign_expires_at(datetime = DEFAULT_EXPIRES_AT)
    self.expires_at = datetime
  end

  def assign_token(t)
    self.token = t
  end
end
