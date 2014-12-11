class Credential < BaseModel
  PROVIDERS = {
    facebook:  "facebook",
    onmyblock: "onmyblock"
  }.freeze

  field :confirmed_at,   type: DateTime
  field :digest,         type: String
  field :identification, type: String
  field :provider,       type: String, default: PROVIDERS[:onmyblock]
  field :user_id

  validates :provider, inclusion: { in: PROVIDERS.values }
  validates_presence_of :digest, :identification, :user_id

  has_many :keys, dependent: :destroy

  belongs_to :user

  index({ identification: 1 }, { unique: true })
end
