require "rails_helper"

RSpec.describe UserCredentialService do
  let(:service) { UserCredentialService.new service_options }
  let(:service_options) { 
    FactoryGirl.attributes_for(:user).merge({ password: "password" })
  }

  describe "#build_credential" do
    it "should return a built credential with the same attributes" do
      credential = service.build_credential
      expect(credential.identification).to eq(
        service_options[:email])
      expect(credential.password).to eq service_options[:password]
    end
  end

  describe "#build_user" do
    it "should return a built user with the same attributes" do
      user = service.build_user
      expect(user.email).to eq service_options[:email]
      expect(user.first_name).to eq service_options[:first_name]
      expect(user.last_name).to eq service_options[:last_name]
    end
  end

  context "services" do
    let(:service) { UserCredentialService.new({}, nil) }

    describe "#create_credential_service" do
      it "should return a CreateService object with credential record" do
        expect(service.create_credential_service({}).record.class
          ).to eq Credential
      end
    end

    describe "#create_user_service" do
      it "should return a CreateService object with user record" do
        expect(service.create_user_service({}).record.class).to eq User
      end
    end
  end
end
