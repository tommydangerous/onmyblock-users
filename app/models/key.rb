class Key
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  DEFAULT_DAYS       = 3
  DEFAULT_EXPIRES_AT = Time.zone.now + DEFAULT_DAYS.days
  KEY_TYPES = {
    access: "access",
    reset:  "reset"
  }.freeze

  field :credential_id
  field :expires_at,   type: DateTime
  field :key_type,     type: String, default: KEY_TYPES[:access]
  field :token,        type: String

  validates :key_type, inclusion: { in: KEY_TYPES.values }
  validates_presence_of :credential_id, :expires_at, :token, :key_type
  validates_uniqueness_of :token, case_sensitive: false

  belongs_to :credential

  index(credential_id: 1)
  index(token: 1)

  def self.generate_access_token
    SecureRandom.uuid
  end

  def assign_expires_at(datetime = DEFAULT_EXPIRES_AT)
    self.expires_at = datetime
  end

  def assign_token(tok = Key.generate_access_token)
    self.token = tok
  end

  def configure_defaults
    assign_expires_at
    assign_token
  end

  def expired?
    expires_at <= Time.now
  end

  def user
    @user ||= credential.user
  end
end
