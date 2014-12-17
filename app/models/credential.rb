class Credential < BaseModel
  include ActiveModel::SecurePassword

  PROVIDERS = {
    facebook:  "facebook",
    onmyblock: "onmyblock"
  }.freeze

  field :confirmed_at,    type: DateTime
  field :identification,  type: String
  field :password_digest, as: :digest, type: String
  field :provider,        type: String, default: PROVIDERS[:onmyblock]
  field :user_id

  validate :validate_password
  validates :provider, inclusion: { in: PROVIDERS.values }
  validates_presence_of :password_digest, :identification, :user_id

  has_many :keys, dependent: :destroy

  belongs_to :user

  index({ identification: 1 }, unique: true)
  index(user_id: 1)

  has_secure_password validations: false

  def validate_password
    if password && password.length < 2
      errors.add :password, "must be at least 2 characters"
    end
  end
end
