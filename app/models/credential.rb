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

  validate :validate_password_create, on: :create
  validate :validate_password_update, on: :update
  validates :provider, inclusion: { in: PROVIDERS.values }
  validates_presence_of :identification, :user_id

  has_many :keys, dependent: :destroy

  belongs_to :user

  index({ identification: 1 }, unique: true)
  index(user_id: 1)

  has_secure_password validations: false

  def validate_password_create
    if password.nil? || password.length < 2
      errors.add :password, "must be at least 2 characters"
    end
  end

  def validate_password_update
    if password.present? && password.length < 2
      errors.add :password, "must be at least 2 characters"
    end
  end

  def create_access_key(key_type = nil)
    key = keys.new key_type: key_type
    key.configure_defaults
    key.save
    key
  end

  # def send_confirmation
  #   CredentialMailer.confirmation(self, create_access_key).deliver
  # end
end
