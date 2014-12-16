module Keyable
  extend ActiveSupport::Concern

  def key
    @key ||= read_service.response
  end

  private

  def expired?
    key.expired?
  end

  def read_service
    unless @read_service
      @read_service = ReadService.new Key, token: options[:token]
      @read_service.process
    end
    @read_service
  end
end
