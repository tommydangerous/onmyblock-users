class HealthController < ApplicationController
  before_action :track_event

  def show
    render text: "OK"
  end

  private

  def track_event
    metrics.track event: "Health Check",
                  anonymous_id: SecureRandom.uuid
  end
end
