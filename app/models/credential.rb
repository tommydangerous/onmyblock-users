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

  validates :password_digest, length: { minimum: 2 }
  validates :provider, inclusion: { in: PROVIDERS.values }
  validates_presence_of :password_digest, :identification, :user_id

  has_many :keys, dependent: :destroy

  belongs_to :user

  index({ identification: 1 }, { unique: true })

  has_secure_password validations: false
end
