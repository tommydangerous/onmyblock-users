require "rails_helper"

RSpec.describe CreateKeyService do
  let(:credential) { create :credential }
  let(:service) { described_class.new valid_attributes }
  let(:valid_attributes) { { credential_id: credential.id } }

  describe "#record" do
    it "should return a key" do
      expect(service.record.class).to eq Key
    end

    context "when service record does not exist" do
      it "should send service.record :configure_defaults message" do
        expect(service).to receive :configure_defaults
        service.record
      end
    end

    context "when service record exists" do
      it "should not send service.record :configure_defaults" do
        service.record
        expect(service).not_to receive :configure_defaults
        service.record
      end
    end
  end
end
