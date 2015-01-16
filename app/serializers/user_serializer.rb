class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email

  def id
    object.id.to_s
  end
end
