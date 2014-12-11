require "rails_helper"

RSpec.describe UserCredentialService do
  context "services" do
    let(:service) { UserCredentialService.new({}, nil) }

    describe "#create_credential_service" do
      it "should return a CreateService object with credential record" do
        expect(service.create_credential_service({}).record.class
          ).to eq Credential
      end
    end

    describe "#create_service" do
      it "should return a CreateService object" do
        expect(service.create_service(User, {}).class).to eq CreateService
      end
    end

    describe "#create_user_service" do
      it "should return a CreateService object with user record" do
        expect(service.create_user_service({}).record.class).to eq User
      end
    end
  end
end
