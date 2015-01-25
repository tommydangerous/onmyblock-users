class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  ROLES = {
    admin:    "admin",
    landlord: "landlord",
    parent:   "parent",
    student:  "student"
  }.freeze

  STATUSES = {
    active:   "active",
    blocked:  "blocked",
    inactive: "inactive"
  }.freeze

  field :email,      type: String
  field :first_name, type: String
  field :last_name,  type: String
  field :roles,      type: Array
  field :status,     type: String

  validate :validate_roles
  validate :validate_status
  validates_format_of :email,
                      with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+([A-Za-z0-9]*))\z/i
  validates_presence_of :email, :first_name, :last_name
  validates_uniqueness_of :email

  has_many :credentials, dependent: :destroy

  accepts_nested_attributes_for :credentials

  index({ email: 1 }, unique: true)

  before_save :update_credential_identification

  def validate_roles
    if roles && roles.size > 0 && (roles - ROLES.values).size > 0
      errors.add(:roles, "has an invalid value")
    end
  end

  def validate_status
    if status && !STATUSES.values.include?(status)
      errors.add(:status, "has an invalid value")
    end
  end

  private

  def credential_from_email_was
    @credential_from_email_was ||=
      credentials.find_by(identification: email_was)
  end

  def update_credential_identification
    if email_changed? && credential_from_email_was
      credential_from_email_was.update! identification: email
    end
  end
end
