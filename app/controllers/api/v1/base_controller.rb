class Api::V1::BaseController < ApiController
  def create
    render json: create_service.response, status: create_service.status
  end

  private

  def create_service
    if @create_service.nil?
      @create_service = new_create_service
      @create_service.process if @create_service
    end
    @create_service
  end

  def new_create_service
    # Override this
  end
end
