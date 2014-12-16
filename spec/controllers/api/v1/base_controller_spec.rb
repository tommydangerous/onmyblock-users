require "rails_helper"

RSpec.describe Api::V1::BaseController do
  let(:controller) { described_class.new }

  describe "#authenticate" do
    let(:key)   { create :key }
    let(:token) { key.token }

    before do
      allow(controller).to receive(:authorization) { token }
    end

    context "with correct token" do
      it "should not receive :deny_access" do
        expect(controller).not_to receive :deny_access
        controller.send :authenticate
      end
    end

    context "with incorrect token" do
      let(:token) { "" }

      it "should receive :deny_access" do
        expect(controller).to receive :deny_access
        controller.send :authenticate
      end
    end
  end

  describe "#current_session" do
    it "should assign @current_session" do
      allow(controller).to receive(:authorization) { "" }
      expect(controller.send :current_session).not_to be_nil
    end
  end
end
