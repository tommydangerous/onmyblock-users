require "rails_helper"

RSpec.describe ApiController do
  let(:controller) { described_class.new }

  describe "#render_envelope" do
    it "should create a new Envelope" do
      allow(controller).to receive(:render)
      expect(Envelope).to receive :new
      controller.send :render_envelope, {}
    end
  end
end
