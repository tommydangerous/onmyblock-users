class User < BaseModel
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

  has_many :credentials, dependent: :destroy

  index({ email: 1 }, { unique: true })

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
end
