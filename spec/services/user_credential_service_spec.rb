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

  describe "#process" do
    context "when user is valid" do
      context "when credential is valid" do
        it "should send :save_user message to service" do
          expect(service).to receive :save_user
          service.process
        end

        it "should send :save_credential_from_user message to service" do
          expect(service).to receive :save_credential_from_user
          service.process
        end
      end

      context "when credential is not valid" do
        let(:service_options) { FactoryGirl.attributes_for(:user) }

        it "should not send :save_user message to service" do
          expect(service).not_to receive :save_user
          service.process
        end

        it "should not send :save_credential_from_user message to service" do
          expect(service).not_to receive :save_credential_from_user
          service.process
        end
      end
    end

    context "when user is not valid" do
      let(:service_options) { {} }
      
      it "should not send :save_user message to service" do
        expect(service).not_to receive :save_user
        service.process
      end

      it "should not send :save_credential_from_user message to service" do
        expect(service).not_to receive :save_credential_from_user
        service.process
      end
    end
  end

  describe "#record_valid?" do
    it "should send :valid? message to record" do
      d = double "record"
      allow(d).to receive(:valid?) { true }
      expect(d).to receive :valid?
      service.record_valid? d
    end

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

  describe "#save_credential" do
    it "should save a credential to the database" do
      expect{ service.save_credential }.to change{ Credential.count }.by 1
    end

    it "should return a credential" do
      expect(service.save_credential.class).to eq Credential
    end
  end

  describe "#save_credential_from_user" do
    it "should send :set_credential_to_user message to service" do
      expect(service).to receive :set_credential_to_user
      service.save_credential_from_user
    end

    it "should send :save_credential message to service" do
      expect(service).to receive :save_credential
      service.save_credential_from_user
    end
  end

  describe "#save_user" do
    it "should save a user to the database" do
      expect{ service.save_user }.to change{ User.count }.by 1
    end

    it "should return a user" do
      expect(service.save_user.class).to eq User
    end
  end

  describe "#set_credential_to_user" do
    it "should set the credential's user_id to the user" do
      user = service.save_user
      service.set_credential_to_user
      expect(build_credential.user_id).to eq user.id
    end
  end
end
