require "rails_helper"

RSpec.describe Api::V1::BaseController do
  let(:controller) { described_class.new }
  let(:key)        { create :key }
  let(:token)      { key.token }

  before { allow(controller).to receive(:authorization) { token } }

  describe "#authenticate" do
    context "with token exists" do
      context "when key is not expired" do
        it "should not receive :deny_access" do
          expect(controller).not_to receive :deny_access
          controller.send :authenticate
        end
      end

      context "when key is expired" do
        it "should receive :deny_access" do
          key.update expires_at: Time.now - 1.day
          expect(controller).to receive :deny_access
          controller.send :authenticate
        end
      end
    end

    context "with token does not exist" do
      let(:token) { "" }

      it "should receive :deny_access" do
        expect(controller).to receive :deny_access
        controller.send :authenticate
      end

      it "should receive :render_envelope" do
        expect(controller).to receive :render_envelope
        controller.send :authenticate
      end

      it "should receive :deny_access" do
        expect(controller).to receive :deny_access
        controller.send :authenticate
      end
    end
  end

  describe "#current_session" do
    let(:token) { "" }

    it "should assign @current_session" do
      expect(controller.send :current_session).not_to be_nil
    end
  end

  describe "#deny_access_errors" do
    context "when token does not exist" do
      let(:token) { "" }

      it "should return errors with key :access_denied" do
        expect(controller.send :deny_access_errors).to have_key :access_denied
      end
    end

    context "when token has expired" do
      before { key.update expires_at: Time.now - 1.day }

      it "should return errors with key :session_expired" do
        expect(controller.send :deny_access_errors).to have_key :session_expired
      end
    end
  end
end
