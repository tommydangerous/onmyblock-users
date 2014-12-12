require "rails_helper"

RSpec.describe CreateKeyService do
  let(:credential) { create :credential }
  let(:service) { CreateKeyService.new valid_attributes  }
  let(:valid_attributes) { { credential_id: credential.id } }

  describe "#record" do
    it "should return a key" do
      expect(service.record.class).to eq Key
    end

    context "when service record is nil" do
      it "should send service.record :assign_expires_at message" do
        expect(service).to receive :assign_expires_at
        service.record
      end

      it "should send service.record :assign_token message" do
        expect(service).to receive :assign_token
        service.record
      end
    end

    context "when service record is not nil" do
      before { service.record }
      
      it "should not send service.record :assign_expires_at message" do
        expect(service).not_to receive :assign_expires_at
        service.record
      end

      it "should not send service.record :assign_token message" do
        expect(service).not_to receive :assign_token
        service.record
      end
    end
  end
end
