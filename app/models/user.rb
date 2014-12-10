class User < BaseModel
  include ActiveModel::Model
  
  field :email, type: String
  field :first_name, type: String
  field :last_name, type: String

  validates_format_of :email, 
    with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+([A-Za-z0-9]*))\z/i
  validates_presence_of :email, :first_name, :last_name
end
