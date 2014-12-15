class AuthenticateService < Service
  include Keyable

  def initialize(options, proc = nil)
    @options = options
    @proc    = proc
  end

  def process
    # 1. Find key using params[:token]
    # 2. Check to see if key has expired
    # 3. Execute callback
    callback if key && !expired?
  end

  private

  def callback
    proc.call(key) if proc
  end

  def expired?
    key.expired?
  end
end
