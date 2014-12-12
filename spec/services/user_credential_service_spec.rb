require "rails_helper"

RSpec.describe UserCredentialService do
  let(:build_credential) { service.build_credential }
  let(:build_user) { service.build_user }
  let(:service) { UserCredentialService.new service_options }
  let(:service_options) { 
    FactoryGirl.attributes_for(:user).merge({ password: "password" })
  }

  describe "#build_credential" do
    it "should return a built credential with the same attributes" do
      expect(build_credential.identification).to eq(
        service_options[:email])
      expect(build_credential.password).to eq service_options[:password]
    end
  end

  describe "#build_user" do
    it "should return a built user with the same attributes" do
      expect(build_user.email).to eq service_options[:email]
      expect(build_user.first_name).to eq service_options[:first_name]
      expect(build_user.last_name).to eq service_options[:last_name]
    end
  end

  describe "#record_valid?" do
    context "with valid attributes" do
      it "should return true" do
        expect(service.record_valid?(build_user)).to be true
      end
    end

    context "with invalid attributes" do
      let(:service_options) { {} }

      it "should return false" do
        expect(service.record_valid?(build_user)).to be false
      end
    end
  end
end
