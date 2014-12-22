require "rails_helper"

RSpec.describe ApplicationController do
  controller do
    before_filter :not_found

    def index
    end
  end

  describe "#not_found" do
    before { get :index }

    it { should respond_with :not_found }
  end
end
