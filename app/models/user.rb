class User < MongoModel
  field :email, type: String
  field :first_name, type: String
  field :last_name, type: String

  validates_format_of :email, 
    with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i
  validates_presence_of :email, :first_name, :last_name

  def as_json(options = {})
    {
      email:      email,
      first_name: first_name,
      last_name:  last_name
    }
  end
end
