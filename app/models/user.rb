class User < BaseModel
  # ROLES = {
  #   admin:    "admin",
  #   landlord: "landlord",
  #   parent:   "parent",
  #   student:  "student"
  # }.freeze
  
  field :email,      type: String
  field :first_name, type: String
  field :last_name,  type: String
  field :role,       type: Array

  validates_format_of :email,
    with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+([A-Za-z0-9]*))\z/i
  validates_presence_of :email, :first_name, :last_name
  # validates_inclusion_of :role, in: ROLES, if: role_exists?

  has_many :credentials, dependent: :destroy

  index({ email: 1 }, { unique: true })
end
