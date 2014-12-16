class AuthenticateService < CrudService
  include Keyable

  def initialize(options, proc = nil)
    @options = options
    @proc    = proc
  end

  attr_private :proc

  def process(_condition = nil)
    super key && !expired?
  end

  private

  def callback
    proc ? proc.call(key) : key
  end

  def success_response
    callback
  end
end
