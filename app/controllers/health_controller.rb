class HealthController < ApplicationController
  def show
    render text: "OK"
  end
end
