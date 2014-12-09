class  Credential

  field: user_id,         type:String
  field: identification,  type:String
  field: password_digest,   type:String
  field: provider,        type:String
  field: confirmed_at     type:DateTime

  validates_presence_of :user_id, :identification, :password_hash
end
