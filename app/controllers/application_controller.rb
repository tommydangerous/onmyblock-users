class ApplicationController < ActionController::Base
  include Payload::Controller

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # TODO: update the payload gem when they make a new release
  #       since the gem should define this method.
  def dependencies
    @dependencies ||= Payload::RailsLoader.load
  end

  private

  def metrics
    @metrics ||= dependencies[:metrics_client]
  end

  def not_found
    render nothing: true, status: :not_found
  end
end
