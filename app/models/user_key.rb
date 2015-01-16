class UserKey
  attr_accessor :key, :user

  def initialize(opts = {})
    @key  = opts[:key]
    @user = opts[:user]
  end
end
