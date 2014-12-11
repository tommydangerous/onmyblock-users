class Key < BaseModel
  TYPES = {
    access: "access",
    reset:  "reset"
  }.freeze

  field :expires_at, type: DateTime
  field :token,      type: String
  field :type,       type: String, default: TYPES[:access]

  belongs_to :credential

  validates :type, inclusion: { in: TYPES.values }
  validates_presence_of :expires_at, :token
  validates_uniqueness_of :token, case_sensitive: false
end
