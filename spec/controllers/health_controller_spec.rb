require "rails_helper"

RSpec.describe HealthController do
  context "GET show" do
    before { get :show }

    it { should respond_with :success }

    it "should render OK" do
      expect(response.body).to eq "OK"
    end
  end
end
