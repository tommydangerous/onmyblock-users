require "rails_helper"

RSpec.describe LogoutService do
  let(:key) { create :key }
  let(:options) { { token: key.token } }
  let(:service) { described_class.new options }

  describe "#process" do
    it "should receive :find_and_delete message" do
      expect(service).to receive :find_and_delete
      service.process
    end

    context "when key can be found" do
      it "should destroy the key" do
        service.process
        expect(Key.count).to eq 0
      end

      it "should receive :success_response" do
        expect(service).to receive :success_response
        service.process
      end

      it "should return a response" do
        service.process
        expect(service.response).not_to be_nil
      end
    end

    context "when key cannot be found" do
      let(:options) { { token: "" } }

      it "should destroy the key" do
        key
        service.process
        expect(Key.count).to eq 1
      end

      it "should receive :failure_response" do
        expect(service).to receive :failure_response
        service.process
      end

      it "should return a nil response" do
        service.process
        expect(service.response).to be_nil
      end
    end
  end
end
